From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Mon, 9 Jul 2018 12:06:22 -0400 (EDT)
Subject: [PATCH v2 0/3] Support rseq on arm64
In-Reply-To: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
Message-ID: <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon at arm.com wrote:

> Hello,
> 
> This is version two of the patches previously posted here:
> 
> http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon at arm.com
> 
> Changes since v1 include:
> 
>  * Move abort handler in-line to avoid possibility of it being
>    out-of-range for conditional branch instructions
> 
> I've tested both native and compat (little-endian only) with the selftests
> and they pass successfully on my Seattle box.

For the whole series:

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> 
> Thanks,
> 
> Will
> 
> --->8
> 
> Will Deacon (3):
>  arm64: rseq: Implement backend rseq calls and select HAVE_RSEQ
>  asm-generic: unistd.h: Wire up sys_rseq
>  rseq/selftests: Add support for arm64
> 
> arch/arm64/Kconfig                        |   1 +
> arch/arm64/include/asm/unistd.h           |   2 +-
> arch/arm64/include/asm/unistd32.h         |   2 +
> arch/arm64/kernel/entry.S                 |   2 +
> arch/arm64/kernel/ptrace.c                |   2 +
> arch/arm64/kernel/signal.c                |   3 +
> include/uapi/asm-generic/unistd.h         |   4 +-
> tools/testing/selftests/rseq/param_test.c |  20 +
> tools/testing/selftests/rseq/rseq-arm64.h | 594 ++++++++++++++++++++++++++++++
> tools/testing/selftests/rseq/rseq.h       |   2 +
> 10 files changed, 630 insertions(+), 2 deletions(-)
> create mode 100644 tools/testing/selftests/rseq/rseq-arm64.h
> 
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
