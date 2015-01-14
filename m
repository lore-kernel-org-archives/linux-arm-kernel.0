From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 14 Jan 2015 15:03:44 +0900
Subject: [PATCH 1/4] clk: tegra: make tegra_clocks_apply_init_table()
 arch_initcall
In-Reply-To: <20141216203824.22980.48872.stgit@chromeos-P9X79>
References: <20141216203813.22980.2301.stgit@chromeos-P9X79>
 <20141216203824.22980.48872.stgit@chromeos-P9X79>
Message-ID: <CAAVeFu+Xg+Loh3DC3s4k0u26uiCx-9F6OmDidX+kHKgig39mHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 5:38 AM, Paul Walmsley <paul@pwsan.com> wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
>
> tegra_clocks_apply_init_table() needs to be called after the udelay
> loop has been calibrated (see commit
> 441f199a37cfd66c5dd8dd45490bd3ea6971117d ("clk: tegra: defer
> application of init table") for why that is).  On existing Tegra SoCs
> this was done by calling tegra_clocks_apply_init_table() from
> tegra_dt_init(). To make this also work on ARM64, we need to change
> this into an initcall. tegra_dt_init() is called from
> customize_machine which is an arch_initcall. Therefore this should
> also work on existing 32bit Tegra SoCs.
>
> Tested on Tegra20 (ventana), Tegra30 (beaverboard), Tegra124 (jetson TK1) and
> Tegra132.

Thierry, I don't think this series has ever been reviewed by us? The
patches apply nicely on my tree and look harmless but I would rather
leave that part to you if you don't mind.
