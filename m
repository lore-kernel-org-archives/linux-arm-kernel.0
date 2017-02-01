From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 1 Feb 2017 10:36:31 -0800
Subject: [PATCH 2/2] ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
In-Reply-To: <20170131102114.25085-2-linus.walleij@linaro.org>
References: <20170131102114.25085-1-linus.walleij@linaro.org>
 <20170131102114.25085-2-linus.walleij@linaro.org>
Message-ID: <20170201183631.GJ10531@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 31 Jan 02:21 PST 2017, Linus Walleij wrote:

> This adds the Capella CM3605 ambient light and proximity sensor
> to the APQ8060 DragonBoard device tree. Notice that we also set
> up pin config for the AOUT line and GPIO lines, and that we set
> the default trigger on the infrared LED to associate with the
> "cm3605" trigger so the IR LED is controlled by this the CM3605
> driver.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[..]
> +				mpps at 50 {
> +					dragon_cm3605_mpps: cm3605-mpps {
> +						pinconf {
> +							pins = "mpp5";
> +							function = "analog";
> +							input-enable;
> +							bias-high-impedance;
> +							/* Let's use channel 5 */
> +							qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;

Unrelated to this patch, I did look at how this works on later devices.
It seems like we want to be able to switch the amux-route depending on
which ADC "channel" we're querying - e.g. on DB820c we have thermistors
on 3 different AMUX inputs but we don't have 3 mpps available.

Any thoughts on how to deal with this?

> +							power-source = <PM8058_GPIO_S3>;
> +						};
> +					};
> +				};

Regards,
Bjorn
