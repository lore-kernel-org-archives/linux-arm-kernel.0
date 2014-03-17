From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 10:38:16 +0100
Subject: [GIT PULL v2] SOCFPGA updates for 3.15, version 2
In-Reply-To: <1394427333-9028-1-git-send-email-dinguyen@altera.com>
References: <1394427333-9028-1-git-send-email-dinguyen@altera.com>
Message-ID: <201403171038.16362.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 March 2014, dinguyen at altera.com wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling in these patches for v3.15 version 2. I apologize for
> the build failure in version 1.

Pulled again into next/drivers, but I'm not too happy about the
resolution:

> For this version, I also cherry-picked a commit that was also pulled into
> Chris Ball's mmc tree.
> 
> 9b931361ff09 dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
> 
> Without this patch, I cannot cleanly fix the build error and avoid a merge
> conflict.

That patch should not have been merged through the MMC tree in the first
place, precisely because of this type of conflict. Further, it should not
have tried to fix up the coding style by changing the indentation of an
unrelated DT node.

> [a5d6ac2a dts: socfpga: Add sysmgr node so the gmac can use to reference] will
> fix the build failure in version 1.

And this one should not have been applied on top, but rather folded
into patch that originally broke the build, to ensure clean bisection.

Unfortunately, we're running out of time to do this properly, and going
forward with your branch seems like the best strategy. I realize you
originally sent your branch a couple of weeks ago, so we should have
caught this earlier.


Chris, it would be nice if you could revert d9c3f5df539a "dts: socfpga: Add
support for SD/MMC on the SOCFPGA platform" in your mmc tree now. The
commit is now also present in arm-soc where it belongs, and we will get
a merge conflict if we both carry it, due to the screwup on the
sysmgr node.

	Arnd
