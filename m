From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Jan 2014 18:12:01 +0000
Subject: [PATCH v6 0/3] AArch64: KGDB support
In-Reply-To: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140106181201.GE1096@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijay,

On Thu, Dec 19, 2013 at 11:50:48AM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Based on the step-handler and break-handler hooks patch from
> Sandeepa, KGDB debugging support is added for EL1
> debug in AArch64 mode. Any updates that come for Patch 1 from
> Sandeepa will be rebased in next version
> 
> With second patch,register layout is updated to be inline with GDB tool.
> Basic GDB connection, break point set/clear and info commands
> are supported except step/next debugging
> 
> With third patch, step/next debugging support is added, where in
> pc is updated to point to the instruction to be stepped and
> stopped.
> 
> With fourth patch, the compile time breakpoint instruction
> reordering is fixed by making kgbd_breakpoint() as noinline
> 
> Tested with ARM64 simulator
> 
> v6:
>  - Change pstate register to 8 bytes to make endian nuetral.
>    Use GDB below GDB patch to display pstate in Big endian mode.
>    https://sourceware.org/ml/gdb-patches/2013-12/msg00720.html
>    Thanks to Andrew.

Thanks for getting this new version out. Just a few things before it can be
applied:

  1. Can you please use "arm64:" instead of "AArch64:" in the patch
     subjects?

  2. Can you get an ack from somebody like Jason on the final patch please?

  3. Can you rebase onto the for-next/core branch at the arm64 repo:

       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

     you'll get a trivial conflict against arch/arm64/kernel/Makefile.

  4. Can you make sure that the gdb patch you linked to actually gets
     merged? There is still some discussion by the looks of it.

Cheers,

Will
