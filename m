From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 22 Nov 2011 09:38:02 +0100
Subject: [PATCH 5/5] arm/dt: tegra: Fix SDHCI nodes to match board files
In-Reply-To: <1321911851-10091-5-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
 <1321911851-10091-5-git-send-email-swarren@nvidia.com>
Message-ID: <20111122083802.GK21480@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:44 Mon 21 Nov     , Stephen Warren wrote:
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
it will be better to invert the logic

just enable what you are supposed too

Best Regards,
J.
