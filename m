From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 10:19:05 +0000
Subject: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
In-Reply-To: <20181127062056.GA30285@kroah.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
 <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181126195727.GA9957@kroah.com>
 <CY4PR21MB0773AFA3555BC08A4CC129D4D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181127062056.GA30285@kroah.com>
Message-ID: <20181127101904.GA2928@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 07:20:56AM +0100, Greg KH wrote:
> On Mon, Nov 26, 2018 at 08:56:50PM +0000, Michael Kelley wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>  Monday, November 26, 2018 11:57 AM
> > 
> > > > > You created "null" hooks that do nothing, for no one in this patch
> > > > > series, why?
> > > > >
> > > >
> > > > hv_enable_vmbus_irq() and hv_disable_vmbus_irq() have non-null
> > > > implementations in the ARM64 code in patch 2 of this series.  The
> > > > implementations are in the new file arch/arm64/hyperv/mshyperv.c.
> > > > Or am I misunderstanding your point?
> > > 
> > > So you use a hook in an earlier patch and then add it in a later one?
> > > 
> > > Shouldn't you do it the other way around?  As it is, the earlier patch
> > > should not work properly, right?
> > 
> > The earlier patch implements the hook on the ARM64 side but it is
> > unused -- it's not called.  The later patch then calls it.  Wouldn't the
> > other way around be backwards?
> 
> Ah, it wasn't obvious that the previous patch added it at all, why not
> just make that addition part of this patch?
> 
> > The general approach is for patches 1 and 2 of the series to provide
> > all the new code under arch/arm64 to enable Hyper-V.  But the code
> > won't get called (or even built) with just these two patches because
> > CONFIG_HYPERV can't be selected.  Patch 3 is separate because it
> > applies to architecture independent code and arch/x86 code -- I thought
> > there might be value in keeping the ARM64 and x86 patches distinct. 
> > Patch 4 applies to architecture independent code, and enables the
> > ARM64 code in patches 1 and 2 to be compiled and run when
> > CONFIG_HYPERV is selected.
> > 
> > If combining some of the patches in the series is a better approach, I'm
> > good with that.
> 
> Ok, that makes more sense, if it is easier to get the ARM people to
> review this, that's fine.  Doesn't seem like anyone did that yet :(

It's on the list, but thanks for having a look as well!

Will
