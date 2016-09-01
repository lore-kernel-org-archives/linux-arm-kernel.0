From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 01 Sep 2016 15:03:51 +0200
Subject: [RESEND PATCH 1/3] ARM: dts: Add TOPEET itop core board SCP
 package version
In-Reply-To: <1472648307-3818-1-git-send-email-ayaka@soulik.info>
References: <a35686c3-294b-a16a-2b0e-0ef2fd460244@kernel.org>
 <1472648307-3818-1-git-send-email-ayaka@soulik.info>
Message-ID: <5477278.USWYFxDPfA@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, August 31, 2016 08:58:27 PM Randy Li wrote:
> The TOPEET itop is a samsung exnynos 4412 core board, which have
> two package versions. This patch add the support for SCP version.
> 
> Currently supported are USB3503A HSIC, USB OTG, eMMC, rtc and
> PMIC. The future features are in the based board. Also MFC and
> watchdog have been enabled.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 490 ++++++++++++++++++++++++
>  1 file changed, 490 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

[...]

> +		s5m8767_osc: clocks {

Don't you also need:

			compatible = "samsung,s5m8767-clk";

here?

BTW Does anyone know why there are no users of
"samsung,s2mps11-clk" compatible in the tree
(commit 53c31b3437a6400c6ffc2c9315680217ad84cb6d
"mfd: sec-core: Add of_compatible strings for
clock MFD cells" added it in March 2014)?

> +			#clock-cells = <1>;
> +			clock-output-names = "s5m8767_ap",
> +					"s5m8767_cp", "s5m8767_bt";
> +		};
> +
> +	};
> +};

[...]

> +&rtc {
> +	status = "okay";
> +	clocks = <&clock CLK_RTC>, <&s5m8767_osc S2MPS11_CLK_AP>;
> +	clock-names = "rtc", "rtc_src";
> +};

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
