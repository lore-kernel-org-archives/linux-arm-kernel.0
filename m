From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 13 Nov 2013 17:11:08 +0000
Subject: [PATCH v2 08/13] ARM: use a function table for determining
 instruction interpreter actions
In-Reply-To: <1381871068-27660-9-git-send-email-dave.long@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-9-git-send-email-dave.long@linaro.org>
Message-ID: <1384362668.3392.41.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-10-15 at 17:04 -0400, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> When interpreting instructions use a client-supplied array of functions
> to take action.  This array can then be provided by krpobes, uprobes, or

'to take action' sounds a bit weird to me, how about 'to specify
actions'?

> possibly some other client subsystem.  The interpreter assigns a group
> number to each recognized instruction and invokes the corresponding action
> function.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm/kernel/Makefile         |    2 +-
>  arch/arm/kernel/kprobes-arm.c    |   41 ++
>  arch/arm/kernel/kprobes-common.c |    3 +-
>  arch/arm/kernel/kprobes-thumb.c  | 1016 ++++----------------------------------
>  arch/arm/kernel/kprobes.c        |   10 +-
>  arch/arm/kernel/kprobes.h        |   14 +-
>  arch/arm/kernel/probes-arm.c     |  114 ++---
>  arch/arm/kernel/probes-arm.h     |   37 ++
>  arch/arm/kernel/probes-thumb.c   |  875 ++++++++++++++++++++++++++++++++
>  arch/arm/kernel/probes-thumb.h   |  136 +++++
>  arch/arm/kernel/probes.c         |    9 +-
>  arch/arm/kernel/probes.h         |   15 +-
>  12 files changed, 1288 insertions(+), 984 deletions(-)
>  create mode 100644 arch/arm/kernel/probes-thumb.c
>  create mode 100644 arch/arm/kernel/probes-thumb.h

As I mentioned in comments to patch 7, this patch seems to accidentally
include the thumb code reorg of moving code from kprobes-thumb.c to
probes-thumb.c

I've no other comments on the patch so trimmed the rest...

-- 
Tixy
