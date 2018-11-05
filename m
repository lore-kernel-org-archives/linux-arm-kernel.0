From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Nov 2018 10:20:10 +0100
Subject: [PATCH 14/14] DT: marvell,mmp2: add USB OTG host controller
In-Reply-To: <20180822204307.13251-15-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-15-lkundrak@v3.sk>
Message-ID: <20181105092010.GL4439@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-08-22 22:43:07, Lubomir Rintel wrote:
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/boot/dts/mmp2.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Again, I guess this could be merged with the previous patch. Anyway,
it is also good to go as-is.

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 14a3448f38b9..63d4d5c6fd83 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -124,6 +124,17 @@
>  				#phy-cells = <0>;
>  				status = "disabled";
>  			};
> +
> +			usb_otg0: usb-otg at d4208000 {
> +				compatible = "marvell,pxau2o-ehci";
> +				reg = <0xd4208000 0x200>;
> +				interrupts = <44>;
> +				clocks = <&soc_clocks MMP2_CLK_USB>;
> +				clock-names = "USBCLK";
> +				phys = <&usb_otg_phy0>;
> +				phy-names = "usb";
> +				status = "disabled";
> +			};
>  		};
>  
>  		apb at d4000000 {	/* APB */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/72251b82/attachment.sig>
