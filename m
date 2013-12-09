From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Dec 2013 12:57:05 +0800
Subject: [PATCH] ARM: dts: mxs: Add iio-hwmon to crystalfontz boards
In-Reply-To: <1386362843-20798-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1386362843-20798-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20131209045702.GH825@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 09:47:23PM +0100, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> 
> This won't work until those patches are applied:
>  https://lkml.org/lkml/2013/12/6/676

I won't have this patch in my tree until next cycle.  But if this DTS
change does not cause any regression on my tree, I can still apply it,
and the feature will work when it gets merged into linux-next together
with the driver changes.

>  and http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/216963.html
> 
> However, I'm wondering if it wouldn't make sense to add it directly in
> imx28.dtsi

Since it sounds like a SoC configuration rather than board one, having
the change in imx28.dtsi makes sense to me. 

Shawn

> 
>  arch/arm/boot/dts/imx28-cfa10036.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
> index cabb6171a19d..51ebf36dd7b9 100644
> --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> @@ -114,4 +114,9 @@
>  			default-state = "on";
>  		};
>  	};
> +
> +	iio_hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&lradc 8>;
> +	};
>  };
> -- 
> 1.8.3.2
> 
