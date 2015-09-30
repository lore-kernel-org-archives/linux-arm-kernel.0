From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 30 Sep 2015 10:52:39 +0200
Subject: [RESEND PATCH v2 2/2] ARM: imx6: change default burst size for USB
In-Reply-To: <1443579437-845-2-git-send-email-peter.chen@freescale.com>
References: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
 <1443579437-845-2-git-send-email-peter.chen@freescale.com>
Message-ID: <1443603159.3185.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 30.09.2015, 10:17 +0800 schrieb Peter Chen:
> It can improve the USB performance when choosing larger
> burst size at some systems (bus size is larger), there is
> no side effect if this burst size is larger than bus size.
> 
Just for the record, as it seems too late to stop the train now:

I am _NOT_ happy that the extended binding has been accepted into the
USB tree despite outstanding review comments from me not being addressed
or even answered.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
> 
> Changes for v2:
> - Applies changes for imx6ul
> 
>  arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
>  arch/arm/boot/dts/imx6sl.dtsi  | 6 ++++++
>  arch/arm/boot/dts/imx6sx.dtsi  | 6 ++++++
>  arch/arm/boot/dts/imx6ul.dtsi  | 4 ++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 3d04a17..92c5cc0 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -907,6 +907,8 @@
>  				fsl,usbphy = <&usbphy1>;
>  				fsl,usbmisc = <&usbmisc 0>;
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -919,6 +921,8 @@
>  				fsl,usbmisc = <&usbmisc 1>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -930,6 +934,8 @@
>  				fsl,usbmisc = <&usbmisc 2>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -941,6 +947,8 @@
>  				fsl,usbmisc = <&usbmisc 3>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 057b1d4..2c0faeb 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -690,6 +690,8 @@
>  				fsl,usbphy = <&usbphy1>;
>  				fsl,usbmisc = <&usbmisc 0>;
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -701,6 +703,8 @@
>  				fsl,usbphy = <&usbphy2>;
>  				fsl,usbmisc = <&usbmisc 1>;
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -712,6 +716,8 @@
>  				fsl,usbmisc = <&usbmisc 2>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 70a7c4f..01191c0 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -784,6 +784,8 @@
>  				fsl,usbmisc = <&usbmisc 0>;
>  				fsl,anatop = <&anatop>;
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -795,6 +797,8 @@
>  				fsl,usbphy = <&usbphy2>;
>  				fsl,usbmisc = <&usbmisc 1>;
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -808,6 +812,8 @@
>  				fsl,anatop = <&anatop>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 654009f..28dcd68 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -536,6 +536,8 @@
>  				fsl,usbmisc = <&usbmisc 0>;
>  				fsl,anatop = <&anatop>;
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  
> @@ -547,6 +549,8 @@
>  				fsl,usbphy = <&usbphy2>;
>  				fsl,usbmisc = <&usbmisc 1>;
>  				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x10>;
> +				rx-burst-size-dword = <0x10>;
>  				status = "disabled";
>  			};
>  

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
