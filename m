From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 21 Oct 2015 12:21:33 +0200
Subject: [PATCH 10/19] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <1445422216-29375-11-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-11-git-send-email-sudeep.holla@arm.com>
Message-ID: <5627672D.60108@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/10/2015 12:10, Sudeep Holla a ?crit :
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
> 
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

I'm not against this if the whole series goes further.
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I suspect that we would need to take this patch with us on the AT91
branches that would go to arm-soc. Is it the intentions?

Thanks, bye.


> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/animeo_ip.dts             |  6 +++---
>  arch/arm/boot/dts/at91-foxg20.dts           |  2 +-
>  arch/arm/boot/dts/at91-kizbox.dts           |  4 ++--
>  arch/arm/boot/dts/at91-kizbox2.dts          |  6 +++---
>  arch/arm/boot/dts/at91-kizboxmini.dts       |  4 ++--
>  arch/arm/boot/dts/at91-qil_a9260.dts        |  2 +-
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts |  2 +-
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts |  2 +-
>  arch/arm/boot/dts/at91-sama5d4ek.dts        |  2 +-
>  arch/arm/boot/dts/at91sam9261ek.dts         | 10 +++++-----
>  arch/arm/boot/dts/at91sam9263ek.dts         |  4 ++--
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  4 ++--
>  arch/arm/boot/dts/at91sam9m10g45ek.dts      |  4 ++--
>  arch/arm/boot/dts/at91sam9n12ek.dts         |  2 +-
>  arch/arm/boot/dts/at91sam9rlek.dts          |  4 ++--
>  arch/arm/boot/dts/sama5d35ek.dts            |  2 +-
>  arch/arm/boot/dts/usb_a9260_common.dtsi     |  2 +-
>  arch/arm/boot/dts/usb_a9263.dts             |  2 +-
>  18 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
> index 4e0ad3b82796..0962f2fa3f6e 100644
> --- a/arch/arm/boot/dts/animeo_ip.dts
> +++ b/arch/arm/boot/dts/animeo_ip.dts
> @@ -155,21 +155,21 @@
>  			label = "keyswitch_in";
>  			gpios = <&pioB 1 GPIO_ACTIVE_HIGH>;
>  			linux,code = <28>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		error_in {
>  			label = "error_in";
>  			gpios = <&pioB 2 GPIO_ACTIVE_HIGH>;
>  			linux,code = <29>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		btn {
>  			label = "btn";
>  			gpios = <&pioC 23 GPIO_ACTIVE_HIGH>;
>  			linux,code = <31>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
> index f89598af4c2b..6bf873e7d96c 100644
> --- a/arch/arm/boot/dts/at91-foxg20.dts
> +++ b/arch/arm/boot/dts/at91-foxg20.dts
> @@ -159,7 +159,7 @@
>  			label = "Button";
>  			gpios = <&pioC 4 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x103>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
> index bf18ece0c027..8afe35f64034 100644
> --- a/arch/arm/boot/dts/at91-kizbox.dts
> +++ b/arch/arm/boot/dts/at91-kizbox.dts
> @@ -94,14 +94,14 @@
>  			label = "PB_RST";
>  			gpios = <&pioB 30 GPIO_ACTIVE_HIGH>;
>  			linux,code = <0x100>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		user {
>  			label = "PB_USER";
>  			gpios = <&pioB 31 GPIO_ACTIVE_HIGH>;
>  			linux,code = <0x101>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91-kizbox2.dts b/arch/arm/boot/dts/at91-kizbox2.dts
> index f0b1563cb3f1..50a14568f094 100644
> --- a/arch/arm/boot/dts/at91-kizbox2.dts
> +++ b/arch/arm/boot/dts/at91-kizbox2.dts
> @@ -171,21 +171,21 @@
>  			label = "PB_PROG";
>  			gpios = <&pioE 27 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x102>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		reset {
>  			label = "PB_RST";
>  			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x100>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		user {
>  			label = "PB_USER";
>  			gpios = <&pioE 31 GPIO_ACTIVE_HIGH>;
>  			linux,code = <0x101>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91-kizboxmini.dts b/arch/arm/boot/dts/at91-kizboxmini.dts
> index 9f72b4932634..9682d105d4d8 100644
> --- a/arch/arm/boot/dts/at91-kizboxmini.dts
> +++ b/arch/arm/boot/dts/at91-kizboxmini.dts
> @@ -98,14 +98,14 @@
>  			label = "PB_PROG";
>  			gpios = <&pioC 17 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x102>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		reset {
>  			label = "PB_RST";
>  			gpios = <&pioC 16 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x100>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
> index a9aef53ab764..4f2eebf4a560 100644
> --- a/arch/arm/boot/dts/at91-qil_a9260.dts
> +++ b/arch/arm/boot/dts/at91-qil_a9260.dts
> @@ -183,7 +183,7 @@
>  			label = "user_pb";
>  			gpios = <&pioB 10 GPIO_ACTIVE_LOW>;
>  			linux,code = <28>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index d81474e0bcd6..b0dd58f448fe 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -315,7 +315,7 @@
>  			label = "PB_USER";
>  			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x104>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index 07f46963335b..c34a23b82e1a 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -235,7 +235,7 @@
>  			label = "pb_user1";
>  			gpios = <&pioE 8 GPIO_ACTIVE_HIGH>;
>  			linux,code = <0x100>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
> index 49a59c7e4a5d..d4cf2cf119e4 100644
> --- a/arch/arm/boot/dts/at91-sama5d4ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
> @@ -277,7 +277,7 @@
>  			label = "pb_user1";
>  			gpios = <&pioE 13 GPIO_ACTIVE_HIGH>;
>  			linux,code = <0x100>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> index 2e92ac020f23..facce0ef840b 100644
> --- a/arch/arm/boot/dts/at91sam9261ek.dts
> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> @@ -149,7 +149,7 @@
>  					ti,debounce-tol = /bits/ 16 <65535>;
>  					ti,debounce-max = /bits/ 16 <1>;
>  
> -					linux,wakeup;
> +					wakeup-source;
>  				};
>  			};
>  
> @@ -193,28 +193,28 @@
>  			label = "button_0";
>  			gpios = <&pioA 27 GPIO_ACTIVE_LOW>;
>  			linux,code = <256>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		button_1 {
>  			label = "button_1";
>  			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
>  			linux,code = <257>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		button_2 {
>  			label = "button_2";
>  			gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
>  			linux,code = <258>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		button_3 {
>  			label = "button_3";
>  			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
>  			linux,code = <259>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> index 23381276ffb8..241de040681f 100644
> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> @@ -213,14 +213,14 @@
>  			label = "left_click";
>  			gpios = <&pioC 5 GPIO_ACTIVE_LOW>;
>  			linux,code = <272>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		right_click {
>  			label = "right_click";
>  			gpios = <&pioC 4 GPIO_ACTIVE_LOW>;
>  			linux,code = <273>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> index 57548a2c5a1e..e45c744d3cc8 100644
> --- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> @@ -206,14 +206,14 @@
>  			label = "Button 3";
>  			gpios = <&pioA 30 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x103>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		btn4 {
>  			label = "Button 4";
>  			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
>  			linux,code = <0x104>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index d1ae60a855d4..a251a193d208 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -321,14 +321,14 @@
>  			label = "left_click";
>  			gpios = <&pioB 6 GPIO_ACTIVE_LOW>;
>  			linux,code = <272>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		right_click {
>  			label = "right_click";
>  			gpios = <&pioB 7 GPIO_ACTIVE_LOW>;
>  			linux,code = <273>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		left {
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index efa75064d38a..a00cd1ded131 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -223,7 +223,7 @@
>  			label = "Enter";
>  			gpios = <&pioB 3 GPIO_ACTIVE_LOW>;
>  			linux,code = <28>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
> index 558c9f220bed..8a847c2d8e42 100644
> --- a/arch/arm/boot/dts/at91sam9rlek.dts
> +++ b/arch/arm/boot/dts/at91sam9rlek.dts
> @@ -225,14 +225,14 @@
>  			label = "right_click";
>  			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
>  			linux,code = <273>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  
>  		left_click {
>  			label = "left_click";
>  			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
>  			linux,code = <272>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/sama5d35ek.dts
> index d9a9aca1ccfd..e812f5c1bf70 100644
> --- a/arch/arm/boot/dts/sama5d35ek.dts
> +++ b/arch/arm/boot/dts/sama5d35ek.dts
> @@ -49,7 +49,7 @@
>  			label = "pb_user1";
>  			gpios = <&pioE 27 GPIO_ACTIVE_HIGH>;
>  			linux,code = <0x100>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
> index 12edafefd44a..9beea8976584 100644
> --- a/arch/arm/boot/dts/usb_a9260_common.dtsi
> +++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
> @@ -115,7 +115,7 @@
>  			label = "user_pb";
>  			gpios = <&pioB 10 GPIO_ACTIVE_LOW>;
>  			linux,code = <28>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
> index 68c0de36c339..8cc6edb29694 100644
> --- a/arch/arm/boot/dts/usb_a9263.dts
> +++ b/arch/arm/boot/dts/usb_a9263.dts
> @@ -143,7 +143,7 @@
>  			label = "user_pb";
>  			gpios = <&pioB 10 GPIO_ACTIVE_LOW>;
>  			linux,code = <28>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> 


-- 
Nicolas Ferre
