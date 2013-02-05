From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 5 Feb 2013 11:54:31 +0100
Subject: [PATCH] ARM: kirkwood: of_serial: fix clock gating by removing
 clock-frequency
In-Reply-To: <1359493774-27627-1-git-send-email-jason@lakedaemon.net>
References: <1359493774-27627-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20130205105431.GI652@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 09:09:34PM +0000, Jason Cooper wrote:
> When DT support for kirkwood was first introduced, there was no clock
> infrastructure.  As a result, we had to manually pass the
> clock-frequency to the driver from the device node.
> 
> Unfortunately, on kirkwood, with minimal config or all module configs,
> clock-frequency breaks booting because of_serial doesn't consume the
> gate_clk when clock-frequency is defined.
> 
> The end result on kirkwood is that runit gets gated, and then the boot
> fails when the kernel tries to write to the serial port.
> 
> Fix the issue by removing the clock-frequency parameter from all
> kirkwood dts files.
> 
> Booted on dreamplug without earlyprintk and successfully logged in via
> ttyS0.
> 
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/boot/dts/kirkwood-dns320.dts         | 2 --
>  arch/arm/boot/dts/kirkwood-dns325.dts         | 1 -
>  arch/arm/boot/dts/kirkwood-dockstar.dts       | 1 -
>  arch/arm/boot/dts/kirkwood-dreamplug.dts      | 1 -
>  arch/arm/boot/dts/kirkwood-goflexnet.dts      | 1 -
>  arch/arm/boot/dts/kirkwood-ib62x0.dts         | 1 -
>  arch/arm/boot/dts/kirkwood-iconnect.dts       | 1 -
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts | 1 -
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts    | 1 -
>  arch/arm/boot/dts/kirkwood-lschlv2.dts        | 1 -
>  arch/arm/boot/dts/kirkwood-lsxhl.dts          | 1 -
>  arch/arm/boot/dts/kirkwood-mplcec4.dts        | 1 -
>  arch/arm/boot/dts/kirkwood-nsa310.dts         | 1 -
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts  | 2 --
>  arch/arm/boot/dts/kirkwood-topkick.dts        | 1 -
>  arch/arm/boot/dts/kirkwood.dtsi               | 2 --

Hi Jason,

Maybe you could also remove the clock-frequency parameter from
kirkwood-ns2-common.dtsi ?

Regards,

Simon

>  16 files changed, 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
> index 5bb0bf3..c9c44b2 100644
> --- a/arch/arm/boot/dts/kirkwood-dns320.dts
> +++ b/arch/arm/boot/dts/kirkwood-dns320.dts
> @@ -42,12 +42,10 @@
>  
>  	ocp at f1000000 {
>  		serial at 12000 {
> -			clock-frequency = <166666667>;
>  			status = "okay";
>  		};
>  
>  		serial at 12100 {
> -			clock-frequency = <166666667>;
>  			status = "okay";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
> index d430713..e4e4930 100644
> --- a/arch/arm/boot/dts/kirkwood-dns325.dts
> +++ b/arch/arm/boot/dts/kirkwood-dns325.dts
> @@ -50,7 +50,6 @@
>  			};
>  		};
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "okay";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
> index 2e3dd34..0196cf6 100644
> --- a/arch/arm/boot/dts/kirkwood-dockstar.dts
> +++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
> @@ -37,7 +37,6 @@
>  			};
>  		};
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> index f2d386c..e21ae48 100644
> --- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
> +++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> @@ -38,7 +38,6 @@
>  			};
>  		};
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
> index 1b133e0..bd83b8f 100644
> --- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
> +++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
> @@ -73,7 +73,6 @@
>  			};
>  		};
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
> index 71902da..5335b1a 100644
> --- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
> +++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
> @@ -51,7 +51,6 @@
>  			};
>  		};
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "okay";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
> index 504f16b..12ccf74 100644
> --- a/arch/arm/boot/dts/kirkwood-iconnect.dts
> +++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
> @@ -78,7 +78,6 @@
>  			};
>  		};
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> index 6cae459..93c3afb 100644
> --- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> +++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> @@ -115,7 +115,6 @@
>  		};
>  
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> index 8db3123..5bbd054 100644
> --- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> +++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> @@ -34,7 +34,6 @@
>  		};
>  
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-lschlv2.dts b/arch/arm/boot/dts/kirkwood-lschlv2.dts
> index 9510c9e..9f55d95 100644
> --- a/arch/arm/boot/dts/kirkwood-lschlv2.dts
> +++ b/arch/arm/boot/dts/kirkwood-lschlv2.dts
> @@ -13,7 +13,6 @@
>  
>  	ocp at f1000000 {
>  		serial at 12000 {
> -			clock-frequency = <166666667>;
>  			status = "okay";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/kirkwood-lsxhl.dts b/arch/arm/boot/dts/kirkwood-lsxhl.dts
> index 739019c..5c84c11 100644
> --- a/arch/arm/boot/dts/kirkwood-lsxhl.dts
> +++ b/arch/arm/boot/dts/kirkwood-lsxhl.dts
> @@ -13,7 +13,6 @@
>  
>  	ocp at f1000000 {
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "okay";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> index 262c654..07be213 100644
> --- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
> +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> @@ -91,7 +91,6 @@
>                  };
>  
>                  serial at 12000 {
> -                        clock-frequency = <200000000>;
>                          status = "ok";
>                  };
>  
> diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
> index 5509f96..28d05e4 100644
> --- a/arch/arm/boot/dts/kirkwood-nsa310.dts
> +++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
> @@ -18,7 +18,6 @@
>  	ocp at f1000000 {
>  
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> index 49d3d74..f3cc7c4 100644
> --- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> @@ -18,12 +18,10 @@
>  
>  	ocp at f1000000 {
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
>  		serial at 12100 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
> index cd15452..7dd19ff 100644
> --- a/arch/arm/boot/dts/kirkwood-topkick.dts
> +++ b/arch/arm/boot/dts/kirkwood-topkick.dts
> @@ -17,7 +17,6 @@
>  
>  	ocp at f1000000 {
>  		serial at 12000 {
> -			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index d6ab442..ec2701c 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -57,7 +57,6 @@
>  			reg-shift = <2>;
>  			interrupts = <33>;
>  			clocks = <&gate_clk 7>;
> -			/* set clock-frequency in board dts */
>  			status = "disabled";
>  		};
>  
> @@ -67,7 +66,6 @@
>  			reg-shift = <2>;
>  			interrupts = <34>;
>  			clocks = <&gate_clk 7>;
> -			/* set clock-frequency in board dts */
>  			status = "disabled";
>  		};
>  
> -- 
> 1.8.1.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/222d3a1d/attachment-0001.sig>
