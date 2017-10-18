From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 12:11:23 +0100
Subject: [PATCH v4 10/13] firmware: arm_sdei: Add support for CPU and
 system power states
In-Reply-To: <20171017174432.1684-11-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-11-james.morse@arm.com>
Message-ID: <20171018111122.oawkbq7ncstrhhfm@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:29PM +0100, James Morse wrote:
> When a CPU enters an idle lower-power state or is powering off, we
> need to mask SDE events so that no events can be delivered while we
> are messing with the MMU as the registered entry points won't be valid.
> 
> If the system reboots, we want to unregister all events and mask the CPUs.
> For kexec this allows us to hand a clean slate to the next kernel
> instead of relying on it to call sdei_{private,system}_data_reset().
> 
> For hibernate we unregister all events and re-register them on restore,
> in case we restored with the SDE code loaded at a different address.
> (e.g. KASLR).
> 
> Add all the notifiers necessary to do this. We only support shared events
> so all events are left registered and enabled over CPU hotplug.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
