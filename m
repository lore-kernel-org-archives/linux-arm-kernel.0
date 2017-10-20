From: labbott@redhat.com (Laura Abbott)
Date: Fri, 20 Oct 2017 15:53:50 -0700
Subject: [PATCH 0/4] arm64: Changes to register and stack dumps
In-Reply-To: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
References: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
Message-ID: <f3e4cf91-6965-84e9-0e3a-39a1c24ab1ae@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2017 08:55 AM, Will Deacon wrote:
> Hi all,
> 
> This handful of patches makes some significant changes to how we print
> register/stack dumps and brings us inline with recent changes to x86.
> The main changes are that we no longer print out the 'Exception stack:'
> section and PC/LR values are resolved to a symbol+offset format where
> possible.
> 
> Feedback welcome.
> 

In very petty complaints, I can no longer just use the PC/LR with
addr2line. Yes I can use gdb or one of the scripts but that's a
few more steps when I'm doing debugging on my own. Like I said,
very minor and overall this is good for both security and alignment.

I ran this through several of the LKDTM tests and the backtraces
looked fine. You're welcome to add

Tested-by: Laura Abbott <labbott@redhat.com>

> Will
> 
> --->8
> 
> Mark Rutland (1):
>   arm64: consistently log ESR and page table
> 
> Will Deacon (3):
>   arm64: traps: Don't print stack or raw PC/LR values in backtraces
>   arm64: traps: Pretty-print pstate in register dumps
>   arm64: uapi: Remove PSR_Q_BIT
> 
>  arch/arm64/include/uapi/asm/ptrace.h |  1 -
>  arch/arm64/kernel/process.c          | 24 ++++++++++---
>  arch/arm64/kernel/traps.c            | 65 ++----------------------------------
>  arch/arm64/mm/fault.c                |  7 ++--
>  4 files changed, 28 insertions(+), 69 deletions(-)
> 
