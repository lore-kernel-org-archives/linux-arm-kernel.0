From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Feb 2016 10:32:05 +0000
Subject: [PATCH] arm64: add architecture specified current_pt_regs
In-Reply-To: <CAN1e=SF4iAVZzvs=+rJxmUX_z7KNSwegxWaor3gDfXD-=MAQ4Q@mail.gmail.com>
References: <1455796115-7844-1-git-send-email-zhizhou.zh@gmail.com>
 <20160218115824.GA2538@e104818-lin.cambridge.arm.com>
 <CAN1e=SF4iAVZzvs=+rJxmUX_z7KNSwegxWaor3gDfXD-=MAQ4Q@mail.gmail.com>
Message-ID: <20160219103205.GD27062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 10:30:09AM +0800, Zhi-zhou wrote:
> On Thu, Feb 18, 2016 at 7:58 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > On Thu, Feb 18, 2016 at 07:48:35PM +0800, Zhi-zhou Zhang wrote:
> > > From: zhizhou <zhizhou.zh@gmail.com>
> > >
> > > This patch is based on the implementation of arm. The generic
> > > current_pt_regs is implemented with current->stack. It need to access
> > > memory that would be too expensive.
> >
> > Do you have any performance numbers?
> 
> I'm using QEMU, so no. Actually this macro isn't heavily used. I just
> think using the generic
> implementation is not very nice. It get task_struct from sp_el0, then
> get stack(which is
> equal to sp_el0) from task_struct. There are two unnecessary memory accesses.

I'd much rather use the generic implementation unless there's a compelling
reason not to. "I think it's not very nice" doesn't really cut it for me!

Will
