From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 29 Oct 2015 16:03:20 +0000
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <5630C143.5080103@free.fr> (Mason's message of "Wed, 28 Oct 2015
 13:36:19 +0100")
References: <5630C143.5080103@free.fr>
Message-ID: <yw1xio5pd5mf.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> Hello,
>
> I'm working on a dual-core SoC (Cortex-A9 MPCore) with Linux running
> as the non-secure OS. The secure OS implements some of the APIs used
> in OMAP2 via SMC.
>
> To start the second core, I used to define .smp in my DT_MACHINE_START
> definition, but Arnd wrote: "There are other ways to do [.smp and .restart]
> too, see CPU_METHOD_OF_DECLARE() and register_restart_handler()."
>
> Is CPU_METHOD_OF_DECLARE() the way to go?
> Is it "compatible" with executing smc to ask the secure OS to do whatever
> is needed to start the second core? (I don't understand why starting cores
> is secure OS responsibility.)
>
> I've located three relevant secure OS services:
> get_aux_core_boot
> set_aux_core_boot0
> set_aux_core_boot_addr
>
> I'm looking for guidance. What mach-* should I take as a reference to
> implement "second core startup from non-secure OS"?

See https://github.com/mansr/linux-tangox/commit/717dd5fab87aa90255460ba409970331cb577247

-- 
M?ns Rullg?rd
mans at mansr.com
