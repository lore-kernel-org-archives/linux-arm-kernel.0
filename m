From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 16:48:30 +0100
Subject: [GIT PULL] nommu-fixes, r7 and MPU support for 3.11
In-Reply-To: <51BF2A59.6070400@arm.com>
References: <51B232CA.9060700@arm.com> <51B27207.8060208@arm.com>
 <20130617131927.GE2718@n2100.arm.linux.org.uk> <51BF2A59.6070400@arm.com>
Message-ID: <20130617154830.GK2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 04:25:13PM +0100, Jonathan Austin wrote:
> > You need to ensure that arm_elf_read_implies_exec()
> > returns appropriately for MPU (it needs to return 1 for MPU.)
> > 
> 
> This requirement I wasn't aware of, however. Is it still relevant when we don't have
> elf support (which we don't, without an MMU?)
> 
> It looks to me like binfmt_flat never uses elf_read_implies_exec()...

Well, something needs to set READ_IMPLIES_EXEC in the personality bitmask.
It's not a biggie as the hardware doesn't honour PROT_EXEC, but it's
something to bear in mind if you ever do consider adding that support.

It's interesting that the nommu code does seem to honour READ_IMPLIES_EXEC,
but I haven't found anywhere in the nommu stuff which sets this flag..
but then I haven't looked that hard.
