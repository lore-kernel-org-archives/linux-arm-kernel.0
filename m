From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Aug 2014 10:07:08 -0600
Subject: [PATCH] ARM: dts: Only build dtb if associated Arch and/or SoC
 is enabled
In-Reply-To: <1407852078-31309-1-git-send-email-pbrobinson@gmail.com>
References: <1407852078-31309-1-git-send-email-pbrobinson@gmail.com>
Message-ID: <53EA3BAC.2000104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2014 08:01 AM, Peter Robinson wrote:
> A number of arches (EXYNOS/IMX/TEGRA) are separated out into finer
> grained definitions whether it be sub ARCH or SOC definitions. The
> device tree blobs should only be built if the specific option is
> enabled that supports that device or it might be that there's an
> expectation that the device is supported when in actual fact it's
> not. This ensures only the relevant bits are built.

I'd rather like to get rid of CONFIG_TEGRA_xx_SOC and replace it with 
CONFIG_TEGRA, but I suppose that idea wasn't received well. So,

Acked-by: Stephen Warren <swarren@nvidia.com>

I assume this will be applied to the arm-soc tree, although 
arm at kernel.org wasn't CC'd?

> This also helps to avoid trivial merge conflicts when adding support
> for new boards.

I would expect the opposite. Most new DTs are likely to be for the most 
recent SoC, and hence this will concentrate the edits into a smaller 
part of the file and cause more merge conflicts. That is, if the changes 
are going through different trees, which they should not be, which makes 
merge conflicts less relevant.
