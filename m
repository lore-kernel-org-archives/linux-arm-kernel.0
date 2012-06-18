From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 12:33:39 +0100
Subject: [RFC PATCH 1/8] ARM: gic: Support forcing cpumask for possible
 cpus in the system
In-Reply-To: <1340019011-18642-2-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-2-git-send-email-monstr@monstr.eu>
Message-ID: <20120618113339.GC12029@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 01:30:04PM +0200, Michal Simek wrote:
> gic_set_affinity doesn't support force option. Force option
> should work with all possible cpus in the system not only with
> online cpus.

Neither does x86.  Why do you want this?  Offline CPUs are unable to
receive the interrupt in any case (and must not receive interrupts in
the bringup path until they are online.)
