From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 May 2011 16:26:31 +0100
Subject: [PATCH] arm: Use arch_spin_lock for unwind to avoid lockdep
	deadlock
In-Reply-To: <alpine.LFD.2.02.1105171605080.3078@ionos>
References: <alpine.LFD.2.02.1105171605080.3078@ionos>
Message-ID: <BANLkTikFcwxq7Wp42=MDMrH4dz7NARXWgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 May 2011 15:11, Thomas Gleixner <tglx@linutronix.de> wrote:
> When lockdep traces a lock taken in a module the arm unwinder takes
> unwind_lock which causes a recursive lockdep call deadlocking itself
> on the unwind_lock.
>
> Make unwind_lock an arch_spin_lock to avoid the lockdep call and use
> the raw_local_irq_save/restore() variants to avoid irq tracing as
> well.
>
> Reported-and-tested-by: Torben Hohn <torbenh@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable at kernel.org

Looks fine to me (as the author of this code):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
