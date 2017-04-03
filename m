From: horms@verge.net.au (Simon Horman)
Date: Mon, 3 Apr 2017 06:34:14 -0400
Subject: [PATCH] ARM: dts: r8a7792: Correct Z clock
In-Reply-To: <1491213188-7305-1-git-send-email-geert+renesas@glider.be>
References: <1491213188-7305-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170403103414.GI31988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:53:08AM +0200, Geert Uytterhoeven wrote:
> Unlike other R-Car Gen2 SoCs with Cortex-A15 CPU cores, R-Car V2H does
> not have a programmable Z clock (Cortex-A15 CPU core clock), but uses a
> fixed divider.
> This is similar to the Z2 clock (Cortex-A7 CPU core clock) on R-Car E2.
> 
> Hence:
>   - Remove the Z clock output from the cpg_clocks node, as this implied
>     a programmable clock,
>   - Add the Z clock as a fixed factor clock,
>   - Let the first CPU node point to the new Z clock,
>   - Remove the Z clock index from the bindings (this definition was used
>     by r8a7792.dtsi only, and was not a contract between DT and driver).
> 
> Fixes: 7c4163aae3d8e5b9 ("ARM: dts: r8a7792: initial SoC device tree")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
