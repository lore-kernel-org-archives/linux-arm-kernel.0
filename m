From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Jun 2014 14:20:18 +0800
Subject: [PATCH v2 1/2] ARM: dts: i.MX25: Fix gpt timers clocks.
In-Reply-To: <1403529927-13868-1-git-send-email-denis@eukrea.com>
References: <1403529927-13868-1-git-send-email-denis@eukrea.com>
Message-ID: <20140625062016.GC3242@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:25:26PM +0200, Denis Carikli wrote:
> Without that fix, the board freeze during boot.
> 
> This appeared after the following commit:
>   496f065 ARM: i.MX: Use of_clk_get_by_name() for timer clocks for DT case.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
> - Also fixed the ipg clock
> - Also fixed the ipg and per clocks for the other gpts
> - Also fixed the ipg clock for non-dt init.
> ---
>  arch/arm/boot/dts/imx25.dtsi  |    8 ++++----
>  arch/arm/mach-imx/clk-imx25.c |    2 +-

Please separate dts and kernel code changes.

Shawn
