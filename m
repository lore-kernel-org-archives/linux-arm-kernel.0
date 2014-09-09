From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 09 Sep 2014 08:40:13 -0700
Subject: [PATCH/RFC 4/5] ARM: shmobile: R-Mobile: Add DT support for PM
 domains
In-Reply-To: <1410183344-14756-5-git-send-email-geert+renesas@glider.be>
 (Geert Uytterhoeven's message of "Mon, 8 Sep 2014 15:35:43 +0200")
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
 <1410183344-14756-5-git-send-email-geert+renesas@glider.be>
Message-ID: <7hfvg0kdk2.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Populate the PM domains from DT, and provide support to hook up devices
> to their respective PM domain.
>
> The always-on power area (e.g. C5 on r8a7740) is created as a PM domain
> without software control, to allow Run-Time management of module clocks
> for hardware blocks inside this area in the future.
> Power-on/off latencies are supported.
>
> Limitations and special cases in the non-DT case are handled through
> rmobile_pm_quirks(). Checks for hardcoded PM domain indices should be
> replaced by the analysis of relations between devices and PM domains in
> DT.
>
> Initialization is done from core_initcall(), as the
> "renesas,intc-irqpin" driver uses postcore_initcall().
>
> This is functionally almost equivalent to the non-DT case. Missing are
> Run-Time management of the module clocks (pm_clk_*()), and device
> latencies.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

[...]

> +static int r8a7740_pd_a4s_suspend(void)
> +{
> +	/*
> +	 * The A4S domain contains the CPU core and therefore it should
> +	 * only be turned off if the CPU is in use.

I think you meant "if the CPU is *not* in use."  ?  :)

Kevin
