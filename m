From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 23 Nov 2012 11:02:13 +0100
Subject: [PATCH v3 6/7] usb: chipidea: usbmisc: add mx53 support
In-Reply-To: <20121123065340.GD22420@nchen-desktop>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-7-git-send-email-m.grzeschik@pengutronix.de>
 <20121123065340.GD22420@nchen-desktop>
Message-ID: <50AF49A5.6030708@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2012 07:53 AM, Peter Chen wrote:
> On Wed, Nov 21, 2012 at 03:06:32PM +0100, Michael Grzeschik wrote:
>> This adds mx53 as the next user of the usbmisc driver and makes it
>> possible to disable the overcurrent-detection of the internal phy.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Changes since v2:
>> * added defines for register offsets and bitmasks
>> * fixed disable_oc option for all ports
>>
>>  drivers/usb/chipidea/usbmisc_imx.c |   51 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
>> index e090e0f..b1811df 100644
>> --- a/drivers/usb/chipidea/usbmisc_imx.c
>> +++ b/drivers/usb/chipidea/usbmisc_imx.c
>> @@ -19,6 +19,13 @@
>>  
>>  #define USB_DEV_MAX 4
>>  
>> +#define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08;
>> +#define MX53_USB_UH2_CTRL_OFFSET	0x14;
>> +#define MX53_USB_UH3_CTRL_OFFSET	0x18;
>> +#define MX53_BM_OVER_CUR_DIS_H1		BIT(5)
>> +#define MX53_BM_OVER_CUR_DIS_OTG	BIT(8)
>> +#define MX53_BM_OVER_CUR_DIS_UHx	BIT(30)
>> +
>>  #define MX6_BM_OVER_CUR_DIS		BIT(7)
> 
> As every SoC platform's non-core register mapping is different,
> it is better to use .h to put register bit definition

AFAIK in the kernel we don't make extra .h files any more, if there is
only a single user of the contents.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/f530b8a1/attachment.sig>
