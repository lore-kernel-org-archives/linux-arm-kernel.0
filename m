From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 18:13:39 +0100
Subject: [PATCH v2] arm64/debug: Remove superfluous SMP function call
In-Reply-To: <1459932148-44003-1-git-send-email-anna-maria@linutronix.de>
References: <1459932148-44003-1-git-send-email-anna-maria@linutronix.de>
Message-ID: <20160414171338.GL4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 10:42:28AM +0200, Anna-Maria Gleixner wrote:
> Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this SMP
> function calls are no longer required.
> 
> Replace smp_call_function_single() with a direct call to
> clear_os_lock(). The function writes the OSLAR register to clear OS
> locking. This does not require to be called with interrupts disabled,
> therefore the smp_call_function_single() calling convention is not
> preserved.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>  arch/arm64/kernel/debug-monitors.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied this and the hw_breakpoint one too, thanks.

Will
