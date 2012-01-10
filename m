From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 11:12:22 +0800
Subject: [PATCH 2/2] Kbuild: Use dtc's -d (dependency) option
In-Reply-To: <1326134295-15547-2-git-send-email-swarren@nvidia.com>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
 <1326134295-15547-2-git-send-email-swarren@nvidia.com>
Message-ID: <20120110031220.GC23362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 11:38:15AM -0700, Stephen Warren wrote:
> This hooks dtc into Kbuild's dependency system.
> 
> Thus, for example, "make dtbs" will rebuild tegra-harmony.dtb if only
> tegra20.dtsi has changed yet tegra-harmony.dts has not. The previous
> lack of this feature recently caused me to have very confusing "git
> bisect" results.
> 
> For ARM, it's obvious what to add to $(targets). I'm not familiar enough
> with other architectures to know what to add there. Powerpc appears to
> already add various .dtb files into $(targets), but the other archs may
> need something added to $(targets) to work.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Though I did not look into the patches deeply, I know the problem very
well and it annoys me a lot.  It's great that we have patches to fix
it, so

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
