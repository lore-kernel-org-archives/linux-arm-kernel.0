From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 11:34:32 +0100
Subject: [PATCH v3] Add ARM cpu topology definition
In-Reply-To: <1308940724-2099-1-git-send-email-vincent.guittot@linaro.org>
References: <1308940724-2099-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20110630103432.GV21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 08:38:44PM +0200, Vincent Guittot wrote:
> +	printk(KERN_INFO "cpu %u : thread %d cpu %d, socket %d, mpidr %x\n",
> +		cpuid, cpu_topology[cpuid].thread_id,
> +		cpu_topology[cpuid].core_id,
> +		cpu_topology[cpuid].socket_id, mpidr);
> +
> +}

Please remove that empty blank line before the closing brace.

Also...

cpu 0 : thread -1 cpu 0, socket 0, mpidr 80000000
Calibrating local timer... 199.99MHz.
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters available
CPU1: Booted secondary processor
cpu 1 : thread -1 cpu 1, socket 0, mpidr 80000001
CPU2: Booted secondary processor
cpu 2 : thread -1 cpu 2, socket 0, mpidr 80000002
CPU3: Booted secondary processor
cpu 3 : thread -1 cpu 3, socket 0, mpidr 80000003
Brought up 4 CPUs

It'd be better to have some consistency there - please change from
"cpu %u :" to "CPU%u:".
