From: will.deacon@arm.com (Will Deacon)
Date: Sat, 10 Dec 2011 13:22:23 +0000
Subject: [PATCH 3/4] Add condition code checking to SWP emulation handler.
In-Reply-To: <20111209185450.19655.63570.stgit@localhost6.localdomain6>
References: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
 <20111209185450.19655.63570.stgit@localhost6.localdomain6>
Message-ID: <20111210132222.GD8292@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 06:54:57PM +0000, Leif Lindholm wrote:
> This patch fixes two separate issues with the SWP emulation handler:
> 1: Certain processors implementing ARMv7-A can (legally) take an
>    undef exception even when the condition code would have meant that
>    the instruction should not have been executed.
> 2: Opcodes with all flags set (condition code = 0xf) have been reused
>    in recent, and not-so-recent, versions of the ARM architecture to
>    implement unconditional extensions to the instruction set. The
>    existing code would still have processed any undefs triggered by
>    executing an opcode with such a value.
> 
> This patch uses the new generic ARM instruction set condition code
> checks to implement proper handling of these situations.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
> ---
>  arch/arm/kernel/swp_emulate.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
