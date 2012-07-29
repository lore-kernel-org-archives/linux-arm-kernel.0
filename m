From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 29 Jul 2012 21:52:28 +0100
Subject: [PATCH 17/18] ARM: ux500: Add all encompassing Sound node to
 DB8500 Device Tree
In-Reply-To: <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
Message-ID: <20120729205227.GL4384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:46:01PM +0100, Lee Jones wrote:

>  arch/arm/boot/dts/db8500.dtsi |    8 ++++++++

This is a generic DT include file but...

> +		sound {
> +			compatible = "stericsson,snd-soc-mop500";
> +
> +			stericsson,platform-pcm-dma = <&pcm>;
> +			stericsson,cpu-dai = <&msp1 &msp3>;
> +			stericsson,audio-codec = <&codec>;
> +		};

...this is clearly the board-specific setup for the system, showing how
the CPU and CODEC are hooked up.  This should therefore be in the DT for
whatever board this is you're working on.
