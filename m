From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 16 Aug 2016 15:19:57 -0700
Subject: [PATCH] ARM: dts: add PM8058 LEDs to the APQ8060 Dragonboard
In-Reply-To: <1471376759-9561-1-git-send-email-linus.walleij@linaro.org>
References: <1471376759-9561-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160816221957.GP26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 16 Aug 12:45 PDT 2016, Linus Walleij wrote:

> This adds the PM8058 LEDs as used in the platform.
> 
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-leds at vger.kernel.org
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> These DT bindings have been ACKed by Rob Herring and Bjorn Andersson
> so I think the patch is safe to merge to the Qcom tree.
> ---
>  arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
> index 0abc93e5bb00..b0800b988174 100644
> --- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
> +++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
> @@ -239,6 +239,45 @@
>  						};
>  					};
>  				};
> +
> +				led at 48 {
> +					/*
> +					 * The keypad LED @0x48 is routed to
> +					 * the sensor board where it is
> +					 * connected to an infrared LED
> +					 * SFH4650 (60mW, @850nm) next to the
> +					 * ambient light and proximity sensor
> +					 * Capella Microsystems CM3605.
> +					 */
> +					compatible = "qcom,pm8058-keypad-led";
> +					reg = <0x48>;
> +					label = "proximity0";
> +					default-state = "off";
> +				};
> +				led at 131 {
> +					compatible = "qcom,pm8058-led";
> +					reg = <0x131>;
> +					label = "pm8058:red";
> +					default-state = "off";
> +				};
> +				led at 132 {
> +					/*
> +					 * This is actually green too on my
> +					 * board, but documented as yellow.
> +					 */
> +					compatible = "qcom,pm8058-led";
> +					reg = <0x132>;
> +					label = "pm8058:yellow";
> +					default-state = "off";
> +					linux,default-trigger = "mmc0";
> +				};
> +				led at 133 {
> +					compatible = "qcom,pm8058-led";
> +					reg = <0x133>;
> +					label = "pm8058:green";
> +					default-state = "on";
> +					linux,default-trigger = "heartbeat";
> +				};
>  			};
>  		};
>  
> -- 
> 2.7.4
> 
