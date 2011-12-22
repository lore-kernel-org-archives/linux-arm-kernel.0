From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Dec 2011 19:32:16 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111222193216.GO2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 05:27:30PM +0000, Marc Zyngier wrote:
> The proposal is to convert local timer drivers to be "standalone" (not
> relying on the local timer infrastructure) and to use a CPU notifier
> to have the timer brought up or down on non-boot CPUs.

You do realise that it's pointless having local timers on non-SMP hardware.
On such hardware, you have a single timer instead.

You're also aware I assume that local timers are different from the global
timer itself, and require to have additional callbacks for broadcasting
the global timer tick?

There is a reason why local timers _use_ the common local timer clock event
stuff.
