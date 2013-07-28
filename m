From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Jul 2013 15:39:56 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <20130728131901.GA8864@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1416484.XDfk5G56BI@flatron> <20130728131901.GA8864@netboy>
Message-ID: <2529481.u8xHuXumcd@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 of July 2013 15:19:03 Richard Cochran wrote:
> On Sun, Jul 28, 2013 at 11:12:53AM +0200, Tomasz Figa wrote:
> > I'm not really sure what effect on users this has. Maybe you should
> > define "users".
> 
> ...
> 
> > Care to explain this reasoning?
> 
> Use Case
> ~~~~~~~~
> 
> User acquires a machine running ARM Linux version 3.x, with u-boot
> and dtb in a read only flash partition. The board boots and works just
> fine. However, for his application, the user requires a new kernel
> feature that appeared in version 3.y where y > x. He compiles the new
> kernel, and it also works.

Generally the user does not care where the dtb is stored. He just want to 
upgrade the kernel without thinking about internals.

There are many possible options:

a) The BSP packaging script he received from board vendor, or even kernel 
build system, builds dtb from kernel sources and appends it to built 
zImage. He just flashes the zImage and everything is working correctly.

  This is pretty common case today, as many boards still use legacy 
  bootloaders without native support for DT. See the analogy to board 
  files, being compiled as a part of kernel sources.

b) The user always compiles the kernel and dtb and flashes both at the 
same time.

  This does not differ at all to flashing the kernel alone, except two 
  files, not one, need to be flashed.

By the way, in use case you are describing, changes that dtb wouldn't have 
to be updated are very low, unless the one present in read only memory of 
the board is complete, i.e. fully describes all the available hardware, 
which is unlikely for a dtb built at time of 3.x availability, whenever 
the feature showed up in 3.y (y > x). The user will most likely have to 
update the dtb anyway.

Please note, though, I'm _not_ trying to convince you that this kind of 
solutions is good, as I'm not convinced either. That's why we are 
discussing this.

Best regards,
Tomasz
