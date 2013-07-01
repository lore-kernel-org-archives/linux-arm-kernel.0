From: balbi@ti.com (Felipe Balbi)
Date: Mon, 1 Jul 2013 23:46:33 +0300
Subject: [RFC] wlcore: sdio: add wilink clock providers
In-Reply-To: <1372707250-11998-1-git-send-email-coelho@ti.com>
References: <1372707250-11998-1-git-send-email-coelho@ti.com>
Message-ID: <20130701204633.GB805@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 01, 2013 at 10:34:10PM +0300, Luciano Coelho wrote:
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index 670c3ce..7f061b8 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -65,11 +65,19 @@
>  		enable-active-high;
>  	};
>  
> +
>  	wlan {
> -	     compatible = "ti,wilink6";
> -	     interrupt-parent = <&gpio2>;
> -	     interrupts = <21 0x4>;	/* gpio line 53, high level triggered */
> -	     refclock = <2>;		/* 38.4 MHz */
> +		compatible = "ti,wilink6";
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <21 0x4>;	/* gpio line 53, high level triggered */
> +		clocks = <&refclock>;
> +		clock-names = "refclock";

hmmm, shouldn't you provide both clocks (refclock and tcx0clock)
explicitly here ?

Also, you should probably make it clear that the WiLink module is fed by
the 32K sync clock just to make sure clock usecounts are correctly
incremented ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/09e9beae/attachment.sig>
