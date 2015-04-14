From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Tue, 14 Apr 2015 22:01:27 +0200
Subject: [PATCH 0/9] ARM: tegra: collection of enhancements/fixes
In-Reply-To: <20150414125222.GB13446@ulmo.nvidia.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
 <20150414125222.GB13446@ulmo.nvidia.com>
Message-ID: <1429041687.3963.33.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-04-14 at 14:52 +0200, Thierry Reding wrote:
> This duplicates a lot of a series that I've been carrying locally for
> quite some time but never got around to posting publicly. Sorry about
> that. I'll rebase what I have on top of this and then take this for
> v4.2.

OK, thanks Thierry.

Two questions:

A) You don't think it would make sense to get any of this applied sooner
than v4.2?

B) I would not need to post a second version of this series then?

I just noticed that patch 8 is actually missing the pinmux entry for the
touch interrupt which mandates a second version thereof. Or should I
just send a fix for that as a separate patch later?

BTW: I also noticed another regression with the following two patches
causing a hard freeze on our Apalis/Colibri T30 modules upon starting X
using a plain fbdev driver. This does not happen if I revert those two
commits but it also does not happen if I disable X startup. Do you have
any idea what might cause this?

a9fe46
ARM: tegra: Add memory controller support for Tegra30

6d9adf
ARM: tegra: Enable IOMMU for display controllers on Tegra30
