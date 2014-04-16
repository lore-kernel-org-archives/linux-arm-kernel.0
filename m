From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 14:29:31 +0100
Subject: [PATCH v5 4/4] arm64: is_compat_task is defined both in
 asm/compat.h and linux/compat.h
In-Reply-To: <1394861948-28712-5-git-send-email-takahiro.akashi@linaro.org>
References: <1394705491-12343-1-git-send-email-takahiro.akashi@linaro.org>
 <1394861948-28712-1-git-send-email-takahiro.akashi@linaro.org>
 <1394861948-28712-5-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140416132931.GB1001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 05:39:08AM +0000, AKASHI Takahiro wrote:
> Some kernel files may include both linux/compat.h and asm/compat.h directly
> or indirectly. Since both header files contain is_compat_task() under
> !CONFIG_COMPAT, compiling them with !CONFIG_COMPAT will eventually fail.
> Such files include kernel/auditsc.c, kernel/seccomp.c and init/do_mountfs.c
> (do_mountfs.c may read asm/compat.h via asm/ftrace.h once ftrace is
> implemented).
> 
> So this patch proactively
> 1) removes is_compat_task() under !CONFIG_COMPAT from asm/compat.h
> 2) replaces asm/compat.h to linux/compat.h in kernel/*.c,
>    but asm/compat.h is still necessary in ptrace.c and process.c because
>    they use is_compat_thread().
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
