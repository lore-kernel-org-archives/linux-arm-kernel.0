From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 16:21:35 -0800
Subject: [PATCH 5/5] arm/dt: tegra: Fix SDHCI nodes to match board files
In-Reply-To: <1321911851-10091-5-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
 <1321911851-10091-5-git-send-email-swarren@nvidia.com>
Message-ID: <20111208002135.GK12945@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:44:11PM -0700, Stephen Warren wrote:
> Mark any SDHCI controllers that aren't registered by the board files as
> disabled in the device-tree files.
> 
> In practice, these controllers:
> 
> * Have nothing hooked up to them at all, or
> * For ports intended for SDIO usage, the drivers for anything that might
>   be attached are not in the device-tree yet. If/when drivers appear, the
>   SD/MMC port can be re-enabled.
> 
> The only possible exception is TrimSlice's mico SD slot, but that wasn't
> enabled in the board files before anyway, and doesn't work when all the
> SDHCI controllers are enabled anyway.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.3/boards


-Olof
