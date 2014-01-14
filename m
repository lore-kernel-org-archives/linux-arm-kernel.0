From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jan 2014 21:14:21 -0500
Subject: [PATCH v5 0/4] Fix i2c bus hang on A0 version of the Armada XP
 SoCs
In-Reply-To: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140114021421.GK19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Wed, Jan 08, 2014 at 04:06:25PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here come the 5th version of the series fixing the i2c bus hang on A0
> version of the Armada XP SoCs. It occurred on the early release of the
> OpenBlocks AX3-4 boards. Indeed the first variants of Armada XP SoCs
> (A0 stepping) have issues related to the i2c controller which prevent
> to use the offload mechanism and lead to a kernel hang during boot.
> 
> The main change are the use of marvell,mv78230-a0-i2c and that the
> function mvebu_get_soc_id() is now local to mach-mvebu.
> 
> The first patch add a mean to detect the SoCs version at run-time and
> the second one use this feature in the driver.
> 
> The 3 first patches should be applied on 3.13-rc and on stable kernel
> 3.12 as it fixes a regression introduce by the commit 930ab3d403ae
> "i2c: mv64xxx: Add I2C Transaction Generator support".

Ok, I've pulled this in by cherrypicking the commits.  I needed to add
the 'Fixes: ...' and 'Cc: stable ...' language, so the commit ids were
going to change anyhow.  I also added the note to the binding as we
discussed.  I've also based this against v3.13-rc1 as there doesn't
appear to be any need to drag in everything up to -rc6.

I've pushed this to mvebu/fixes.  Please take a look.  If it all looks
good I'll send the pull request off tomorrow.

thx,

Jason.
