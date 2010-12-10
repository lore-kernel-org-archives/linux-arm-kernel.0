From: christian.glindkamp@taskit.de (Christian Glindkamp)
Date: Fri, 10 Dec 2010 10:03:24 +0100
Subject: [PATCH] at91: Refactor Stamp9G20 and PControl G20 board file
In-Reply-To: <20101210033850.GC19897@game.jcrosoft.org>
References: <4CFFE5A9.4040407@bluewatersys.com>
	<1291889759-12281-1-git-send-email-christian.glindkamp@taskit.de>
	<20101210033850.GC19897@game.jcrosoft.org>
Message-ID: <20101210090324.GB24295@taskit.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-12-10 04:38, Jean-Christophe PLAGNIOL-VILLARD wrote:
> HI,
> 
> 	If the hardware are so near I do need to the need to create a new
> 	machine use system_rev to auto detect it will be better
> 
> 	but we need to have only one defconfig as done on rm9200
> 	it's really reduce the maintainance and allow to be sure when we
> 	compile the at91sam9g20_defconfig that we do not brake any board
> 
> 	if a board have incompatible option please the system_rev to specify
> 	them or a specific entry in the Kconfig for this board it will allow
> 	also to known this information for the maintainance

Just because it is near does not mean it is a revision of the other
board. Just compare
http://www.taskit.de/en/products/portuxg20/index.htm
http://www.taskit.de/en/products/stamp9g20/starterkit.htm

Apart from that, both boards are correctly identifiable via the machine
id for a year, respectively one and a half year for the Stamp9G20 EVB.
Why change it for sake of change?

They both have there own machine id to make it clear that these are
really different boards. I could have also submitted two board files
and maybe nobody would have noticed that share a lot, but I thought code
reuse is better so there are in the same file.

And for different carrier boards, system_rev does not make sense at all.

> 
> Best Regards,
> J.
> On 11:15 Thu 09 Dec     , Christian Glindkamp wrote:
> > As PControl G20 is a carrier board for the Stamp9G20 SoM, some code can
> > be shared. Therefore board-stamp9g20.c is refactored to allow reusing the
> > SoM initialization and board-pcontrol-g20.c is modified to use it.
> > 
> > Signed-off-by: Christian Glindkamp <christian.glindkamp@taskit.de>
> > ---
> > 
> > How about this approach? Compile tested for PControl G20 and run time tested
> > for Stamp9G20 EVB and PortuxG20.
> > 
> > Just a side note: PortuxG20 is not a carrier board for the Stamp9G20. It just
> > shares so much with the evaluation board, that it makes sense to put them both
> > into the same file. And there is no intention to put other boards into this
> > file.
> > 
> >  arch/arm/mach-at91/Makefile                 |    2 +-
> >  arch/arm/mach-at91/board-pcontrol-g20.c     |   98 +--------------------------
> >  arch/arm/mach-at91/board-stamp9g20.c        |   82 ++++++++++++-----------
> >  arch/arm/mach-at91/include/mach/stamp9g20.h |    7 ++
> >  4 files changed, 54 insertions(+), 135 deletions(-)
> >  create mode 100644 arch/arm/mach-at91/include/mach/stamp9g20.h
