From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 21 Jan 2015 17:23:21 +0100
Subject: [alsa-devel] [PATCH v2 3/3] ARM: dts: Add sound nodes for
 exynos4412-trats2
In-Reply-To: <1421660902-29679-4-git-send-email-ideal.song@samsung.com>
References: <1421660902-29679-1-git-send-email-ideal.song@samsung.com>
 <1421660902-29679-4-git-send-email-ideal.song@samsung.com>
Message-ID: <54BFD279.7080604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/01/15 10:48, Inha Song wrote:
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts

> +	sound {
> +		compatible = "samsung,trats2-audio";

> +		assigned-clocks = <&pmu_system_controller 0>;
> +		assigned-clock-parents =  <&clock CLK_XUSBXTI>;

How about putting these properties in the pmu_system_controller
node?  After all the mux clock being configured here belongs to
the PMU subsystem. Wouldn't it work that way ?

> +		samsung,i2s-controller = <&i2s0>;
> +		samsung,model = "Trats2";
> +		samsung,audio-codec = <&wm1811>;
> +		samsung,audio-routing =
> +			"SPK", "SPKOUTLN",
> +			"SPK", "SPKOUTLP",
> +			"SPK", "SPKOUTRN",
> +			"SPK", "SPKOUTRP";
> +	};

-- 
Regards,
Sylwester
