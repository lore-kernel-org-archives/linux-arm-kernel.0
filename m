From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 16 Nov 2012 10:28:28 +0100
Subject: [PATCH 4/4] ARM: dts: imx: add imx5x phy-mode entries
In-Reply-To: <20121116071519.GE2941@S2100-06.ap.freescale.net>
References: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352988014-14769-5-git-send-email-m.grzeschik@pengutronix.de>
 <20121116071519.GE2941@S2100-06.ap.freescale.net>
Message-ID: <50A6073C.2010509@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 08:15 AM, Shawn Guo wrote:
> On Thu, Nov 15, 2012 at 03:00:14PM +0100, Michael Grzeschik wrote:
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/imx51.dtsi |    2 ++
>>  arch/arm/boot/dts/imx53.dtsi |    2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
>> index 366b8d3..ffc6bc8 100644
>> --- a/arch/arm/boot/dts/imx51.dtsi
>> +++ b/arch/arm/boot/dts/imx51.dtsi
>> @@ -145,6 +145,7 @@
>>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>>  				reg = <0x73f80200 0x0200>;
>>  				interrupts = <14>;
>> +				phy-mode = "utmiw";
> 
> I tried to grep "phy-mode" and "utmiw" on linux-next and found nothing.
> So it's not something we can take for 3.8, right?

But it wouldn't hurt, if we agree on a common usb phy-mode binding helper.

> PS. Instead, I found something like phy_type = "utmi_wide" in
> fsl-usb.txt and fsl-mph-dr-of.c.  Should these be consolidated into
> a common binding?

This is exactly what Michael is trying to do:
http://permalink.gmane.org/gmane.linux.usb.general/74747

If there already is "umti_wide" we should use that, instead of "umtiw".

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/756d635d/attachment.sig>
