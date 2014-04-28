From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:32:10 -0700
Subject: [PATCH v9 05/17] ARM: dts: sun4i: Add pin-muxing info for the
 mmc0 controller
In-Reply-To: <1398507381-5614-6-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20140428193210.GF3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sat, Apr 26, 2014 at 12:16:09PM +0200, Hans de Goede wrote:
> mmc0 is the only controller actually being used on boards, so limit the
> pin-muxing options to that.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index dce074b..29fd4f5 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -565,6 +565,20 @@
>  				allwinner,drive = <0>;
>  				allwinner,pull = <0>;
>  			};
> +
> +			mmc0_pins_a: mmc0 at 0 {
> +				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
> +				allwinner,function = "mmc0";
> +				allwinner,drive = <2>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			mmc0_cd_pin_a: mmc0_cd_pin at 0 {
> +				allwinner,pins = "PH1";
> +				allwinner,function = "gpio_in";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <1>;
> +			};

Actually, I like very much the reference_pin mention you had in your
bindings documentation. Could you use it for this and the other
patches?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/acce3749/attachment-0001.sig>
