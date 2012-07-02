From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 02 Jul 2012 09:54:08 +0200
Subject: [PATCH 1/2] arm: imx: enable flexcan on imx25, imx35, imx53, imx6q
In-Reply-To: <20120702075054.GF2698@pengutronix.de>
References: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
 <1341175565-13218-2-git-send-email-mkl@pengutronix.de>
 <20120702075054.GF2698@pengutronix.de>
Message-ID: <4FF153A0.3030404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2012 09:50 AM, Sascha Hauer wrote:
> On Sun, Jul 01, 2012 at 10:46:04PM +0200, Marc Kleine-Budde wrote:
>> Cc: Sascha Hauer <sha@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  arch/arm/mach-imx/Kconfig |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index eff4db5..c296851 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -52,6 +52,7 @@ config SOC_IMX25
>>  	select ARCH_MX25
>>  	select COMMON_CLK
>>  	select CPU_ARM926T
>> +	select HAVE_CAN_FLEXCAN if CAN
> 
> Do we need the 'if CAN' here? It seems yes, since HAVE_CAN_FLEXCAN is
> inside the "CAN Device Drivers" menu which depends on CAN. Shouldn't the
> HAVE_CAN_FLECAN be outside the menu?

Yes, we can move the HAVE_CAN_FLEXCAN outside of that menu, but it still
depends on CONFIG_NET.

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/ae72385b/attachment.sig>
