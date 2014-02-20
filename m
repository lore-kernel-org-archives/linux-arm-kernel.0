From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 20 Feb 2014 11:34:36 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140220105854.GL11878@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
Message-ID: <1392896076.23342.37.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding debian-arm/-kernel)
On Thu, 2014-02-20 at 11:58 +0100, Andrew Lunn wrote:
> On Thu, Feb 20, 2014 at 10:30:17AM +0000, Ian Campbell wrote:
> > On Fri, 2014-02-07 at 18:34 +0100, Sebastian Hesselbarth wrote:
> > > On 02/07/2014 12:42 AM, Andrew Lunn wrote:
> > > > Now that all the device tree support is in mach-mvebu, remove it from
> > > > mach-kirkwood.
> > > >
> > > > Regenerate kirkwood_defconfig, removing all DT support, and a couple
> > 
> > s/DT/board-file/?
> 
> We keep any system using -setup.c files, and remove the ability to
> boot systems with a DT description. Thus mach-kirkwood becomes legacy,
> and you should now be trying to only use mach-mvebu, compiled for v5
> systems and a second compile for v7 systems.

Just to check I've got it: The majority of the systems previously
supported by mach-kirkwood (either board file or DTB based) are now
supported by mach-mvebu.

Is it possible to have both ARCH_KIRKWOOD and ARCH_MVEBU in the same
v5 .config? IOW that all of the platforms currently supported by the
Debian kirkwood flavour remain supportable in the same binary after this
change. It looks like it should be to me, but I'm not 100% sure.

If not then Debian will need to introduce a new kernel flavour and
manage the transition somehow, which is going to be tricky if we need to
retain both flavours.

Is there a tree I can pull to see what is going into v3.15 in this area?

> There are four systems left in mach-kirkwood which don't have DT
> equivalent. These are LaCie 2Big and 5Big, HP t5325 thin client and
> Marvell OpenRD machines. I'm working on t5325 and Openrd. The sticking
> point is audio support, which no other board has done with DT yet.
> The two LeCie boards have a custom LED driver which needs a DT
> binding. My gut feeling is that we won't get these four converted to
> DT in time for 3.15.
>  
> > > > of other redundent options have been removed in the process.
> > > >
> > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > > ---
> > > 
> > > Hmm, I wonder what Ian thinks of removing this so quickly again...
> > 
> > I don't want to stand in the way of progress. What version is this
> > targeting so I can setup our tooling to DTRT and append a DTB under the
> > correct circumstances.
> 
> My aim is 3.15. Most patches have been Acked now, so i think we are on
> track for that.

If kirkwood and mvebu are mutually exclusive on v5 then this sounds like
it might end up being more complicated than just setting Append-DTB-From
in the flash-kernel db. In that case if we could hold off on pulling the
existing kirkwood support until there is a transition plan here I'd be
very grateful.

Ian.
