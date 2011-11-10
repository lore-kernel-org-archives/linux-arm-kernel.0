From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 09 Nov 2011 16:37:43 -0800
Subject: [PATCH 1/2] fs: binfmt_elf: Create Kconfig variable for PIE
 randomization.
In-Reply-To: <1320885178-24201-1-git-send-email-david.daney@cavium.com>
References: <1320885178-24201-1-git-send-email-david.daney@cavium.com>
Message-ID: <4EBB1CD7.6040502@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2011 04:32 PM, David Daney wrote:
> Randomization of PIE load address is hard coded in binfmt_elf.c for
> X86 and ARM.  Create a new Kconfig variable
> (CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE) for this and use it instead.
> Thus architecture specific policy is pushed out of the generic
> binfmt_elf.c and into the architecture Kconfig files.
> 
> X86 and ARM Kconfigs are modified to select the new variable so there
> is no change in behavior.  A follow on patch will select it for MIPS
> too.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86 at kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-fsdevel at vger.kernel.org
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: H. Peter Anvin <hpa@zytor.com>
