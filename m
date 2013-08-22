From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 06:54:35 -0700
Subject: [GIT PULL 2/5] ARM: imx: soc changes for 3.12
In-Reply-To: <1376833688-24542-2-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Sun, 18 Aug 2013 21:48:05 +0800")
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <87li3tvnj8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:
>
>   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.12
>
> for you to fetch changes up to 0c383e6a56c2e70db9f2a68f9fe095645f11c151:
>
>   phy: micrel: Add definitions for common Micrel PHY registers (2013-08-18 09:30:39 +0800)
>
> ----------------------------------------------------------------
> It contains a bunch of imx soc updates for 3.12.
>
> - Add more ethernet phy fixups for imx6 boards
> - Add some missing imx6q clocks into clock driver
> - Add new clock types fixup mux and div to work around some ugly
>   hardware defect
> - Consolidate L2 cache initialization function, so that it can be used
>   on more i.MX SoCs
> - Replace magic numbers in mach-imx6q.c with well defined macros
> - Support low-level debug for vybrid

This patch causes a conflict with Russell's DEBUG_LL cleanup, which is
already in linux-next.

For v3.12, I suggest you drop this patch and rework your new DEBUG_LL
support on top of Russell's cleanup.  Have a look at that and see if you
can reuse the the generic 8250 stuff added by Russell.  While there, you
might look at imx.S as well.

If that's OK with you, can you send an updated pull request without the
DEBUG_LL changes?  The other changes look OK for v3.12.

Kevin
