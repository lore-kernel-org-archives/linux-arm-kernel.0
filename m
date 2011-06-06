From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2011 17:30:09 +0100
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <4DECCADE.6080100@selfish.org>
References: <4DECCADE.6080100@selfish.org>
Message-ID: <20110606163009.GB7448@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 02:41:02PM +0200, Holger Freyther wrote:
> Unable to handle kernel paging request at virtual address 5ffffc1b
> [5ffffc1b] *pgd=00000000
> Internal error: Oops: 801 [#1] PREEMPT
> Modules linked in: ...
> CPU: 0    Tainted: G         C   (3.0.0-rc2-00006-gff5f4d6-dirty #68)
> PC is at irq_gc_mask_clr_bit+0x38/0x40
> LR is at gpio_irq_handler+0x44/0xdc
> pc : [<c0d6f3a4>]    lr : [<c0d29a74>]    psr: 60000093
> sp : c10abe68  ip : 00000001  fp : c10abe74
> r10: 00000000  r9 : c10b69d0  r8 : 00000001
> r7 : fec67010  r6 : 0000ffff  r5 : 00000038  r4 : 00000038
> r3 : 0000001c  r2 : 00000400  r1 : 5ffffbff  r0 : c70050f0
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0005317f  Table: 85cfc000  DAC: 00000017
> Process swapper (pid: 0, stack limit = 0xc10aa270)
> Stack: (0xc10abe68 to 0xc10ac000)
> be60:                   c10abeac c10abe78 c0d29a74 c0d6f37c c0d3c028 c0d2c79c
> be80: 00000000 c10c0b80 00000038 00000000 00000002 00000001 c10aa000 00000000
> bea0: c10abebc c10abeb0 c0d6c0d8 c0d29a40 c10abedc c10abec0 c0d1e038 c0d6c0b4
> bec0: 60000013 ffffffff fec48000 60000013 c10abf8c c10abee0 c0d1eb4c c0d1e010
> bee0: 00000001 00000000 0075287d 00000000 c10b52e0 c10b52e0 60000013 60000013
> bf00: ffff9214 c10b4508 00000000 c10abf8c c10abec0 c10abf28 c0d56068 c0d610a4
> bf20: 60000013 ffffffff 00000002 c0d20e24 c0d20e44 00000004 4f482f80 ffff920b
> bf40: 055d4a80 00000000 4f6b9d83 00000004 c10b0d00 60000013 4f6b9d83 00000004
> bf60: 00000000 c10aa000 c10cc2c4 c10b0514 c10b0698 80004000 41069265 80021e74
> bf80: c10abfac c10abf90 c0d2003c c0d60dc8 00000002 c10cc220 c0d1924c c11dc480
> bfa0: c10abfc4 c10abfb0 c0fd10fc c0d20014 00000000 c10ac8f4 c10abff4 c10abfc8
> bfc0: c00089c4 c0fd1088 c00083d4 00000000 00000000 c0d1924c 00053175 c10ac010
> bfe0: c0d19248 c10b050c 00000000 c10abff8 8000803c c0008740 00000000 00000000
> Backtrace:
> [<c0d6f36c>] (irq_gc_mask_clr_bit+0x0/0x40) from [<c0d29a74>]
> (gpio_irq_handler+0x44/0xdc)
> [<c0d29a30>] (gpio_irq_handler+0x0/0xdc) from [<c0d6c0d8>]
> (generic_handle_irq+0x34/0x48)
> [<c0d6c0a4>] (generic_handle_irq+0x0/0x48) from [<c0d1e038>]
> (asm_do_IRQ+0x38/0x8c)
> [<c0d1e000>] (asm_do_IRQ+0x0/0x8c) from [<c0d1eb4c>] (__irq_svc+0x4c/0x90)

Where is the code line for this oops dump?
