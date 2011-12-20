From: frank.rowand@am.sony.com (Frank Rowand)
Date: Mon, 19 Dec 2011 17:36:55 -0800
Subject: [RFC PATCH v2 0/6] ARM: Remove the __ARCH_WANT_INTERRUPTS_ON_CTXSW
 definition
In-Reply-To: <1324306673-4282-1-git-send-email-catalin.marinas@arm.com>
References: <1324306673-4282-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <4EEFE6B7.2010101@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/11 06:57, Catalin Marinas wrote:
> Hi,
> 
> This is version 2 of the set of patches for removing
> __ARCH_WANT_INTERRUPTS_ON_CTXSW on ARM. The series was updated to allow
> for the pgd switch not to be deferred if switch_mm() is called with
> interrupts enabled. This is required for cases where switch_mm() is
> called directly (currently from use_mm() and idle_task_exit()) without a
> corresponding finish_arch_post_lock_switch() call. The original changes
> to activate_mm() were also reverted since switch_mm() can do the actual
> pgd switch when the interrupts are enabled.
> 
> If there are no objections, I'd like to push the series to -next to get
> more exposure (the patches are aimed for 3.4-rc1 unless other issues are
> found in the meantime).

Version 2 looks good to me.  Thanks!

-Frank
