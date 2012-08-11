From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Aug 2012 19:18:55 -0400
Subject: [PATCH 3/3] ARM: Kirkwood: add DT boards to defconfig
In-Reply-To: <20120811220645.GB2856@lunn.ch>
References: <cover.1344651264.git.jason@lakedaemon.net>
 <a0e20df2d8ad6dbcf66fa9a14482a305c4a109fe.1344651264.git.jason@lakedaemon.net>
 <20120811220645.GB2856@lunn.ch>
Message-ID: <20120811231855.GH22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 12, 2012 at 12:06:45AM +0200, Andrew Lunn wrote:
> On Sat, Aug 11, 2012 at 02:39:47AM +0000, Jason Cooper wrote:
> > Also, disable DEBUG_KERNEL, enable SERIAL_OF_PLATFORM, and enable EMBEDDED
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> >  arch/arm/configs/kirkwood_defconfig |   12 +++++++++++-
> >  1 files changed, 11 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> > index 5a494a3..0865d2e 100644
> > --- a/arch/arm/configs/kirkwood_defconfig
> > +++ b/arch/arm/configs/kirkwood_defconfig
> > @@ -3,6 +3,9 @@ CONFIG_SYSVIPC=y
> >  CONFIG_NO_HZ=y
> >  CONFIG_HIGH_RES_TIMERS=y
> >  CONFIG_LOG_BUF_SHIFT=19
> > +CONFIG_NAMESPACES=y
> > +CONFIG_BLK_DEV_INITRD=y
> > +CONFIG_EMBEDDED=y
> >  CONFIG_PROFILING=y
> >  CONFIG_OPROFILE=y
> >  CONFIG_KPROBES=y
> > @@ -17,6 +20,13 @@ CONFIG_MACH_MV88F6281GTW_GE=y
> >  CONFIG_MACH_SHEEVAPLUG=y
> >  CONFIG_MACH_ESATA_SHEEVAPLUG=y
> >  CONFIG_MACH_GURUPLUG=y
> > +CONFIG_MACH_DREAMPLUG_DT=y
> > +CONFIG_MACH_ICONNECT_DT=y
> > +CONFIG_MACH_DLINK_KIRKWOOD_DT=y
> > +CONFIG_MACH_IB62X0_DT=y
> > +CONFIG_MACH_TS219_DT=y
> > +CONFIG_MACH_GOFLEXNET_DT=y
> > +CONFIG_MACH_LSXL_DT=y
> 
> Depending on the order things get merged, it would be good if
> Sebastians' and Ians' new boards are also enabled.

Agreed, I'll hold off on this until we get theirs upstream, then I'll
push v3 including their boards.

In the future, new boards should include a change to the appropriate
defconfig to enable building them.  I'll make sure to mention it on
anything new coming in.

thx,

Jason.
