From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Feb 2014 16:58:17 +0000
Subject: [PATCH v2 3/3] arm64: is_compat_task is defined both in
 asm/compat.h and linux/compat.h
In-Reply-To: <1393320025-2855-4-git-send-email-takahiro.akashi@linaro.org>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-4-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140228165817.GE30996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 09:20:25AM +0000, AKASHI Takahiro wrote:
> kernel/seccomp.c includes linux/compat.h and, indicrectly, asm/compat.h
> via asm/syscall.h. Due to the duplicated definitions of is_compat_task,
> compiling this file will fail in the case of !CONFIG_COMPAT.
> So this patch
> 1) removes is_compat_task() definition from asm/compat.h
> 2) replaces asm/compat.h to linux/compat.h in kernel/*.c
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---

You built this, right? If so,

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
