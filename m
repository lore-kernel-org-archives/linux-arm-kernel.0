From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 7 Feb 2014 10:20:47 +0100
Subject: [PATCH 19/21] ARM: MVEBU: Simplifiy headers and make local
In-Reply-To: <20140207093104.7197224d@skate>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-20-git-send-email-andrew@lunn.ch>
 <20140207093104.7197224d@skate>
Message-ID: <20140207092047.GD17758@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 09:31:04AM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri,  7 Feb 2014 00:42:15 +0100, Andrew Lunn wrote:
> > kirkwood is very nearly fully DT. Remove most of the address
> > definitions from the header files and make it a local header file.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/mach-mvebu/include/mach/bridge-regs.h |  85 ---------------
> >  arch/arm/mach-mvebu/include/mach/kirkwood.h    | 142 -------------------------
> >  arch/arm/mach-mvebu/kirkwood-pm.c              |   2 +-
> >  arch/arm/mach-mvebu/kirkwood.c                 |   2 +-
> >  arch/arm/mach-mvebu/kirkwood.h                 |  22 ++++
> >  5 files changed, 24 insertions(+), 229 deletions(-)
> >  delete mode 100644 arch/arm/mach-mvebu/include/mach/bridge-regs.h
> >  delete mode 100644 arch/arm/mach-mvebu/include/mach/kirkwood.h
> >  create mode 100644 arch/arm/mach-mvebu/kirkwood.h
> 
> Is there any particular reason why this isn't part of PATCH 14/21. I
> was very surprised when reading PATCH 14/21 to see a file named
> "bridge-regs.h" containing Kirkwood-specific definitions added to
> mach-mvebu, and so many address constants being defined, while we are
> DT-based only in mach-mvebu.

Hi Thomas

I wanted to keep 14/21 as a simple move of files, doing the minimal
needed to make it boot. The patches that follow then clean up. I found
that simpler to follow what was going on, since there is nothing
hidden in the move patch.

I can however squash these together if that is what people want to
see.

	Andrew
