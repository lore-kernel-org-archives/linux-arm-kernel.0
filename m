From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Oct 2017 16:35:51 +0100
Subject: [PATCH 1/2] arm64: Ensure the instruction emulation is ready for
 userspace
In-Reply-To: <20171006131653.15876-1-suzuki.poulose@arm.com>
References: <20171006131653.15876-1-suzuki.poulose@arm.com>
Message-ID: <20171006153550.cng3w5ahxuzlivxa@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 06, 2017 at 02:16:52PM +0100, Suzuki K. Poulose wrote:
> We trap and emulate some instructions (e.g, mrs, deprecated instructions)
> for the userspace. However the handlers for these are registered as
> late_initcalls and the userspace could be up and running from the initramfs
> by that time (with populate_rootfs, which is a rootfs_initcall()). This
> could cause problems for the early applications ending up in failure
> like :
> 
> [   11.152061] modprobe[93]: undefined instruction: pc=0000ffff8ca48ff4
> 
> This patch promotes the specific calls to core_initcalls, which are
> guaranteed to be completed before we hit userspace.
> 
> Cc: stable at vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: James Morse <james.morse@arm.com>
> Reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Both patches queued for 4.14. Thanks.

-- 
Catalin
