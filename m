From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Nov 2018 10:20:04 +0100
Subject: [PATCH 13/14] DT: marvell,mmp2: add OTG PHY
In-Reply-To: <20180822204307.13251-14-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-14-lkundrak@v3.sk>
Message-ID: <20181105092004.GK4439@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-08-22 22:43:06, Lubomir Rintel wrote:
> The USB OTG PHY chip. To be used by the OTG controller.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

>  arch/arm/boot/dts/mmp2.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 766bbb8495b6..14a3448f38b9 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -117,6 +117,13 @@
>  				reg-names = "mux status", "mux mask";
>  				mrvl,intc-nr-irqs = <2>;
>  			};
> +
> +			usb_otg_phy0: usb-otg-phy at d4207000 {
> +				compatible = "marvell,mmp2-usb-phy";
> +				reg = <0xd4207000 0x40>;
> +				#phy-cells = <0>;
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/727a271a/attachment.sig>
