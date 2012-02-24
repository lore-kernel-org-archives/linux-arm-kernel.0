From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Feb 2012 11:00:04 +0000
Subject: [PATCH 1/3] ARM: add support for the generic syscall.h interface
In-Reply-To: <4F44FF90.4090009@mentor.com>
References: <4F44FF58.3060907@mentor.com>
 <4F44FF90.4090009@mentor.com>
Message-ID: <20120224110004.GE13504@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wade,

On Wed, Feb 22, 2012 at 02:45:36PM +0000, Wade Farnsworth wrote:
> Supplying the asm-generic/syscall.h interface is a
> pre-requisite for HAVE_ARCH_TRACEHOOK
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
> ---
>  arch/arm/include/asm/syscall.h |   93 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 93 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/syscall.h

[...]

> +
> +static inline void syscall_set_return_value(struct task_struct *task,
> +					    struct pt_regs *regs,
> +					    int error, long val)
> +{
> +	regs->ARM_r0 = (long) error ?: val;
> +}

This looks like far too much fun for kernel code, although I see that '?:'
does appear elsewhere in the kernel. Usually in perl regexs though :)

Will
