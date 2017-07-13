From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Jul 2017 10:20:44 +0200
Subject: [PATCH v2] ARM: shmobile: rcar-gen2: Add support for CPG/MSSR
 bindings
In-Reply-To: <1499855972-22126-1-git-send-email-geert+renesas@glider.be>
References: <1499855972-22126-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170713082043.GO5580@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 12:39:32PM +0200, Geert Uytterhoeven wrote:
> When using the new CPG/MSSR bindings, there is no longer a
> "renesas,rcar-gen2-cpg-clocks" node, and the code to obtain the external
> clock crystal frequency falls back to a default of 20 MHz.
> While this is correct for all upstream R-Car Gen2 and RZ/G1 boards, this
> is not necessarily the case for out-of-tree third party boards.
> 
> Add support for finding the external clock crystal oscillator on RZ/G1M,
> and on R-Car H2, M2-W, and M2-N using the new CPG/MSSR bindings, through
> the corresponding "renesas,r8a77xx-cpg-mssr" nodes.
> 
> Note that this is not needed on R-Car V2H and E2, and on RZ/G1E, as on
> those SoCs the arch_timer and generic counter clock is derived from the
> ZS clock instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Drop RZ/G1E,
>   - Add support for R-Car H2, M2-W, and M2-N.

Thanks, applied for v4.14.
