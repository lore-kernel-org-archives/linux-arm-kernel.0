From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Aug 2013 10:26:00 +0100
Subject: [PATCH] ARM: Fix memblock_reserve() to include stext
In-Reply-To: <CANqRtoQkfDcCNYdYJMpf4zc3P0=kuV-LJFva33vSmio6YAOBrQ@mail.gmail.com>
References: <20130731055807.14054.70106.sendpatchset@w520>
 <20130731094352.GV24642@n2100.arm.linux.org.uk>
 <CANqRtoR5j2VyRwf0suABfVLxzU30pZndEcCj7uZ2sSrzfGmx_A@mail.gmail.com>
 <20130731193930.GY24642@n2100.arm.linux.org.uk>
 <CANqRtoQkfDcCNYdYJMpf4zc3P0=kuV-LJFva33vSmio6YAOBrQ@mail.gmail.com>
Message-ID: <20130802092600.GN23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 12:24:17PM +0900, Magnus Damm wrote:
> On Thu, Aug 1, 2013 at 4:39 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Aug 01, 2013 at 04:34:03AM +0900, Magnus Damm wrote:
> >> Are you aware of any existing fix for this or anyone working on
> >> solving this issue? If not then I don't mind stepping up. I can
> >> however think of quite a few other things to do if this has been
> >> solved already though, so please let me know if you think I should
> >> focus on fixing this.
> >
> > I committed a fix for it this morning, so it should be in linux-next by
> > tomorrow.
> 
> Thanks for writing a fix, Russell. I cherry picked the following
> commit from linux-arm:
> 
> cd717a2 ARM: Add .text annotations where required after __CPUINIT removal
> 
> Applying it on top of kernel.org renesas git tag
> renesas-devel-20130801v2 (v3.11-rc3 + v3.12 material) solves the
> problem for me. I just tested this on KZM9G hardware without and with
> the patch, so I can confirm that CPU Hotplug is now working again.
> 
> Tested-by: Magnus Damm <damm@opensource.se>

It should've ended up in Linus' tree last night, but from the looks of
how quiet things seem to be, I guess everyone's away on August vacations
at the moment.
