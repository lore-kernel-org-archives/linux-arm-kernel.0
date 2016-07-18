From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jul 2016 13:59:51 +0100
Subject: [stable:PATCH] valid_user_regs() backport
In-Reply-To: <1468844845-6129-1-git-send-email-james.morse@arm.com>
References: <1468844845-6129-1-git-send-email-james.morse@arm.com>
Message-ID: <20160718125951.GD10069@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 01:27:22PM +0100, James Morse wrote:
> Hi all,

Hi James,
 
> These three copies of the same patch backport dbd4d7ca563f
> ("arm64: Rework valid_user_regs") to the stable kernels listed on kernel.org
> as far back as v3.16.
> 
> This patch fixed a userspace triggerable oops when userspace tries
> to switch to a mode not supported by the kernel:
> [  286.628508] Bad mode in Synchronous Abort handler detected, code 0x46000000 -- SVC (AArch32)
> [  286.639625] CPU: 3 PID: 2072 Comm: inter Not tainted 4.4.14 #4504
> [  286.648391] Hardware name: ARM Juno development board (r1) (DT)
> [ ... ]
> [  286.716784] Bad mode in Synchronous Abort handler detected, code 0x86000007 -- IABT (current EL)
> [  286.725483] CPU: 3 PID: 2072 Comm: inter Not tainted 4.4.14 #4504
> [  286.731513] Hardware name: ARM Juno development board (r1) (DT)
> [ ... ]
> [  286.840815] Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP
> [  286.846673] Modules linked in:
> [  286.849699] CPU: 3 PID: 2072 Comm: inter Not tainted 4.4.14 #4504
> [  286.855728] Hardware name: ARM Juno development board (r1) (DT)

Thanks for doing this.

Having looked over them, I believe that the fixups for all three
backport patches are correct. So FWIW, for all the patches:

Reviewed-by: Mark Rutland <mark.rutland@arm.com> [backport]

Thanks,
Mark.
