From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 May 2017 20:40:44 +0200
Subject: [PATCH v4 0/3] arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
In-Reply-To: <1494852253-8572-1-git-send-email-geert+renesas@glider.be>
References: <1494852253-8572-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170515184041.GA23926@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 02:44:10PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds support for Renesas Salvator-X and H3ULCB
> development boards equipped with revision ES2.0 of the R-Car H3 SoC.
> 
> Our goal is to have a single kernel image supporting both ES1. and ES2.0
> revisions of the R-Car H3 SoC, and let r8a7795-salvator-x.dtb and
> r8a7795-h3ulcb.dtb represent the latest production hardware.
> As R-Car H3 ES1.x SoCs are pre-production revisions, the DTB files for
> these revisions are renamed to r8a7795-es1-salvator-x.dtb resp.
> r8a7795-es1-h3ulcb.dtb.
> 
> While this will cause a slight inconvenience for developers using
> pre-production hardware, it will make it easier to deploy production
> hardware, and phase out support for pre-production hardware later.
> Note that unless you need access to new features not yet described in
> DT, you can keep on using the existing DTBs on pre-production hardware.
> 
>   - Patch 1 adds support for the R-Car H3 ES2.0 Soc, by providing 2
>     .dtsi files: r8a7795.dtsi (ES2.0), and r8a7795-es1.dtsi (ES1.x).
>   - Patch 2 adds support for Salvator-X with R-Car H3 ES2.0 by providing
>     2 .dts files: r8a7795-salvator-x.dts (ES2.0), and
>     r8a7795-es1-salvator-x.dts(ES1.x),
>   - Patch 3 adds support for ator-X with R-Car H3 ES2.0 by providing 2
>     .dts files: r8a7795-salvator-x.dts (ES2.0), and
>     r8a7795-es1-salvator-x.dts(ES1.x).
> 
> While patch 1 has no user-visible impact, patches 2 and 3 do.
> 
> Changes compared to v3:
>   - Remove "/remove/overrides", as r8a7795-es1.dtsi does additions only,
>   - Move node and property deletion guidelines above the scissors,
>   - Rebase on top of r8a7795 HDMI support (but most of that is "hidden"
>     thanks to git's smart copy from/to patch format),
> 
> Changes compared to v2:
>   - Rebase on top of common Salvator-X board support extraction,
>   - Remove the "compatible" property from the DU node in r8a7795.dtsi,
>     in addition to the "vsps" property,
>   - Add support for ES2.0-based H3ULCB.
> 
> For changes compared to v1 (which was not posted), please refer to the
> individual patches.
> 
> Dependencies:
>   - This patch series is against renesas-devel-20170515-v4.12-rc1,
>   - Thanks to git's smart copy from/to patch format, it should be
>     applicable with and without "[PATCH 0/2] arm64: dts: salvator-x: Move
>     HDMI0 to common Salvator-X board support".
> 
> This series is available in the topic/r8a7795es2-dt-v4 branch of my
> renesas-drivers git repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> An integration branch (incl. all dependencies) for testing is provided
> as topic/r8a7795es2-integration.  I plan to update this branch when any
> of the dependencies are updated.
> 
> This has been tested on Salvator-X (H3 ES1.0 and ES2.0), and H3ULCB with
> H3 ES1.1.
> 
> This has not been tested on H3ULCB with H3 ES2.0 due to lack of
> hardware, so perhaps you want to defer patch 3. However, adding ES2.0
> support to both boards at the same time has its advantages (e.g. to answer
> the question "in which kernel version do I need a DTB with 'es1' in its
> name?").
> 
> Thanks for applying (at least) the first two patches!

Thanks, patches 1 and 2 queued up.
I'd rather not take 3 until it can be tested somehow.
