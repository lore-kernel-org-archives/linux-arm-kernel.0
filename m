From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 18 Feb 2011 15:48:43 -0800
Subject: [PATCH 1/3] ARM: Tegra: Add pll_d table entries for 252MHz
In-Reply-To: <AANLkTimp==gtU2jvCYExqoV6tv-_dgvsF0yAf_k-F7CX@mail.gmail.com>
References: <1298071093-23865-1-git-send-email-swarren@nvidia.com>
	<1298071093-23865-2-git-send-email-swarren@nvidia.com>
	<AANLkTimp==gtU2jvCYExqoV6tv-_dgvsF0yAf_k-F7CX@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A58DE@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erik Gilling wrote at Friday, February 18, 2011 4:46 PM:
>
> These look good.  Have you run these through a CTS tester at 720x480
> and 1280x720?  We pass those now and I want to make sure there's not
> regressions.  We're supposed to be getting one in a week or two.  If
> you haven't run it by then, I'll run a pass with these then merge.

Unfortunately, I don't have one available, so no.

(although I don't believe I made any changes to clocking, CTS, or N
for those two modes, just 640x480).

Thanks for the review and offer to test!

> 
> Cheers,
>    Erik
> 
> On Fri, Feb 18, 2011 at 3:18 PM, Stephen Warren <swarren@nvidia.com>
> wrote:
> > This rate is required for correct generation of 640x480 HDMI video;
> > see subsequent patches.
> >
> > Note: I tested the entry with 12MHz input. The other entries are untested,
> > but appear logically correct. However, I'm not familiar enough with PLLs
> > to know if they perhaps exceed the PLL VCO frequency, nor whether the
> > cpcon values are strictly correct.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > ?arch/arm/mach-tegra/tegra2_clocks.c | ? ?5 +++++
> > ?1 files changed, 5 insertions(+), 0 deletions(-)

-- 
Nvpublic
