From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Feb 2013 11:55:14 +0100
Subject: [PATCH 3/3] USB mxs-phy: Register phy with framework
In-Reply-To: <87y5e8wzbs.fsf@ashishki-desk.ger.corp.intel.com>
References: <1361974590-21237-1-git-send-email-mkl@pengutronix.de>
 <1361974590-21237-4-git-send-email-mkl@pengutronix.de>
 <20130228080127.GB6544@arwen.pp.htv.fi> <512F21A5.2040303@pengutronix.de>
 <87y5e8wzbs.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <512F3792.2030403@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2013 10:40 AM, Alexander Shishkin wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> writes:
> 
>> On 02/28/2013 09:01 AM, Felipe Balbi wrote:
>>> hi,
>>>
>>> On Wed, Feb 27, 2013 at 03:16:30PM +0100, Marc Kleine-Budde wrote:
>>>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>>>
>>>> We now have usb_add_phy_dev(), so use it to register with the framework
>>>> to be able to find the phy from the USB driver.
>>>>
>>>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Reviewed-by: Peter Chen <peter.chen@freescale.com>
>>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>>
>>> any chance you can move away from {write,read}[bwl]_relaxed() so we can
>>> build this driver on other architectures ?
>>
>> The hardware is in the ARM imx2{2,8} only. Another option would be to
>> add an "depends on ARCH_ARM".
> 
> Doesn't mean that we shouldn't be able to compile-test the driver.

Fixed in the just posted otg-for-v3.10-v2 series.

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/599582fb/attachment.sig>
