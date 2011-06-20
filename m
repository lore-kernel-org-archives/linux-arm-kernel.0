From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 10:50:53 +0100
Subject: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
In-Reply-To: <1308561839-18407-1-git-send-email-santosh.shilimkar@ti.com>
References: <1308561839-18407-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110620095053.GA2082@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 02:53:59PM +0530, Santosh Shilimkar wrote:
> The current ARM CPU hotplug code suffers from couple of race conditions
> in CPU online path with scheduler.
> The ARM CPU hotplug code doesn't wait for hot-plugged CPU to be marked
> active as part of cpu_notify() by the CPU which brought it up before
> enabling interrupts.

Hmm, why not just move the set_cpu_online() call before notify_cpu_starting()
and add the wait after the set_cpu_online() ?
