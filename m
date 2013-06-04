From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Jun 2013 09:25:47 +0800
Subject: [PATCH] ARM: tegra: remove the ifdef of ARCH SoC in the
 tegra_resume
In-Reply-To: <201306040048.13612.arnd@arndb.de>
References: <1370247004-31846-1-git-send-email-josephl@nvidia.com>
 <51ACB59D.9030005@wwwdotorg.org>  <201306040048.13612.arnd@arndb.de>
Message-ID: <1370309147.2341.6.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-06-04 at 06:48 +0800, Arnd Bergmann wrote:
> On Monday 03 June 2013, Stephen Warren wrote:
> > Was that ifdef completely incorrect before? I can see why the cmp/beq
> > might be ifdef'd (although it's not worth it), but I assume the code
> > after that beq was intended to run on all chips after Tegra20. The ifdef
> > as it was written does something rather different; it prevents any of
> > that code from running unless the kernel doesn't have Tegra20 support.
> > So, I think that the removal of the ifdef is more of a bug-fix that
> > "because we always build with all Tegra SoCs support. Let me know, and
> > I'll re-write the commit description to something more accurate...
> 
> The #ifdef was recently changed from #if TEGRA3 to #if !TEGRA2, which support
> for TEGRA4 was added. I think this is where it broke.
> 
Yes, exactly. Sorry again for the error code.

Joseph
