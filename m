From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jun 2010 14:10:07 +0100
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <4C0E3CAF.4050409@weinigel.se>
References: <4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<4C0E3CAF.4050409@weinigel.se>
Message-ID: <20100608131007.GE25370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 08, 2010 at 02:50:55PM +0200, Christer Weinigel wrote:
> Linus isn't stupid.  If you explain what you are doing and that the goal  
> is to reduce the set of defconfigs to just one per processor family, and  
> that it will reduce the churn in the end, I think Linus will listen.

Linus has said in no uncertain terms that all but one or two ARM defconfigs
will be deleted at the next merge window.  That's not "one or two defconfigs
per platform class".

> Actually, why not just ask Linus if the the way Ben Dooks has structured  
> the Samsung defconfigs would be ok with him.  It's only one defconfig  
> per CPU family and each defconfig supports a lot of boards.

When you look at what Linus is complaining about in the diffstat, you
realise that the S3C stuff is part of the problem.  This is what the
diffstat for arch/arm/configs looks like for the period covering
2.6.34 to 2.6.35-rc1 - which is the one which provoked Linus' reaction.

 arch/arm/configs/am3517_evm_defconfig        |  144 +++-
 arch/arm/configs/ams_delta_defconfig         |   10 +-
 arch/arm/configs/cns3420vb_defconfig         |  831 +++++++++++++
 arch/arm/configs/devkit8000_defconfig        |  157 ++-
 arch/arm/configs/mmp2_defconfig              |   75 +-
 arch/arm/configs/mx51_defconfig              |   17 +-
 arch/arm/configs/omap3_defconfig             |  151 ++-
 arch/arm/configs/omap3_evm_defconfig         |   51 +-
 arch/arm/configs/omap3_stalker_lks_defconfig | 1691 ++++++++++++++++++++++++++
 arch/arm/configs/omap_4430sdp_defconfig      |  448 +++++++-
 arch/arm/configs/rx51_defconfig              |   39 +-
 arch/arm/configs/s3c2410_defconfig           |  719 ++++++-----
 arch/arm/configs/s3c6400_defconfig           |  637 +++++++++-
 arch/arm/configs/s5p6440_defconfig           |   87 +-
 arch/arm/configs/s5p6442_defconfig           |   66 +-
 arch/arm/configs/s5pc100_defconfig           |  235 +++-
 arch/arm/configs/s5pc110_defconfig           |   52 +-
 arch/arm/configs/s5pv210_defconfig           |   55 +-
 arch/arm/configs/spear300_defconfig          |  773 ++++++++++++
 arch/arm/configs/spear310_defconfig          |  775 ++++++++++++
 arch/arm/configs/spear320_defconfig          |  775 ++++++++++++
 arch/arm/configs/spear600_defconfig          |  760 ++++++++++++
 arch/arm/configs/stamp9g20_defconfig         | 1456 ++++++++++++++++++++++
 23 files changed, 9323 insertions(+), 681 deletions(-)

Notice that almost a third (7/23) of the files were Samsung related.

It's also not just about the number of defconfigs.  Linus had other
valid points too - for example, you can't review the changes to them
properly, because any change to them is far too noisy.  That point
doesn't go away by reducing the number of defconfigs.

> s3c2410_defconfig supports most ARM9 based Samsung SoCs, S3C2410,  
> S3C2412, S3C2413, S3C2440 and S3C2442, all in all some 20-odd boards. So 
> for someone who wants to start a new S3C port they can just use the  
> s3c2410_defconfig as a base, which I think is how Linus want's the  
> defconfigs to be used.

I think Linus has made up his mind about what he wants to see, and that's
what we have to provide him with.  However, if you think you've got a
great alternative, please get involved with the thread on LKML and see if
_you_ can change his mind.
