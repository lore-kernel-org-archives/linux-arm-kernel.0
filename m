From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 20:22:33 +0200
Subject: [PATCH] arm: omap: make wakeupgen_lock raw
In-Reply-To: <1354891787-24119-1-git-send-email-balbi@ti.com>
References: <1354891787-24119-1-git-send-email-balbi@ti.com>
Message-ID: <20130124182159.GL4424@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 07, 2012 at 04:49:47PM +0200, Felipe Balbi wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> When applying RT patch on top of Linux, spinlocks are
> implemented as RT-mutexes, which means they are preemptable.
> 
> Current GIC implementation on OMAP is using a spinlock
> to protect against preemption. As it turns out, we need
> to convert that lock into a raw_spinlock so that OMAP's
> interrupt controller works as expected after RT-patch
> is applied.
> 
> This patch is simply to decrease the amount of changes
> RT-team needs to carry out of tree. It doesn't cause any
> changes in behavior.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

ping

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/5315f067/attachment.sig>
