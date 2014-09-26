From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 26 Sep 2014 18:19:04 +0100
Subject: [PATCH] perf tools: fix build breakage on arm and arm64 targets
In-Reply-To: <1411750918-25220-1-git-send-email-will.deacon@arm.com>
References: <1411750918-25220-1-git-send-email-will.deacon@arm.com>
Message-ID: <5425A008.2030901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 26/09/14 18:01, Will Deacon wrote:
> Attempting to build the perf tool on arm or arm64 targets results in the
> following failure:
>
> arch/arm/util/unwind-libunwind.c: In function ?libunwind__arch_reg_id?:
> arch/arm/util/unwind-libunwind.c:43:3: error: implicit declaration of function ?pr_err? [-Werror=implicit-function-declaration]
>     pr_err("unwind: invalid reg id %d\n", regnum);
>     ^
> This is due to commit 84f5d36f4866 ("perf tools: Move pr_* debug macros
> into debug object") moving the pr_* macros into a new header file, but
> failing to update architectures other than x86.
>
> This patch adds the missing includes, and fixes the build again.
>

For ARM64, we also need the patch[1] "perf tools: Fix arm64 build error" 
which is already queued in linux-next.

Regards,
Sudeep

[1] https://lkml.org/lkml/2014/6/24/1024
