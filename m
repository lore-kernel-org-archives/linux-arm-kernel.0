From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Oct 2013 17:39:32 -0700
Subject: [PATCH] ARM: tegra: fix Tegra114 IOMMU register address
In-Reply-To: <1383175068-27420-1-git-send-email-swarren@wwwdotorg.org>
References: <1383175068-27420-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOesGMiBK9=g0+RjX4xKFb2gtjVCHwz1ZdAxYP99=pzfSdU+3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 4:17 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Hiroshi Doyu <hdoyu@nvidia.com>
>
> The IOMMU node's reg property contains completely bogus values! Somehow,
> this had no practical effect, despite the fact the IOMMU driver appears
> to be writing to those registers. I suppose that since no HW modules is
> actually at that address, the writes simply had no effect.
>
> Note that I'm not CCing stable here, even though the problem exists as
> far back as v3.9, simply because this patch doesn't fix any observed
> issue, and I don't want to run the risk of suddenly writing to some
> registers and causing a regression.
>
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> [swarren, wrote commit description]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Kevin, Olof, if you could apply this directly for 3.13, that's be awesome.

Applied to next/dt.


-Olof
