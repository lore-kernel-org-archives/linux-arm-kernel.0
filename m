From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Mar 2010 20:49:30 +0000
Subject: [PATCH] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002"
In-Reply-To: <1268745149-8685-1-git-send-email-santosh.shilimkar@ti.com>
References: <1268745149-8685-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100316204930.GA13948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 06:42:29PM +0530, Santosh Shilimkar wrote:
> This patch fixes the preempt leak in the cpuidle path invoked from
> cpu-hotplug
> log:
> BUG: scheduling while atomic: swapper/0/0x00000002
> <d>Modules linked in:
> Backtrace:
> [<c0024f90>] (dump_backtrace+0x0/0x110) from [<c01762c4>] (dump_stack+0x18/0x1c)
>  r7:c0218cc4 r6:c0341f00 r5:c7836000 r4:00000000
> [<c01762ac>] (dump_stack+0x0/0x1c) from [<c003d94c>] (__schedule_bug+0x60/0x70)
> [<c003d8ec>] (__schedule_bug+0x0/0x70) from [<c0176914>] (schedule+0x98/0x7b8)
>  r5:c7836000 r4:c7836000
> [<c017687c>] (schedule+0x0/0x7b8) from [<c00228c4>] (cpu_idle+0xb4/0xd4)
> # [<c0022810>] (cpu_idle+0x0/0xd4) from [<c01744e8>] (secondary_start_kernel+0xe0/0xf0)
>  r5:c7836000 r4:c020a220
> [<c0174408>] (secondary_start_kernel+0x0/0xf0) from [<c0031150>] (set_cpu_power_state+0x40/0x44)
>  r7:c0218cc4 r6:00000001 r5:00000001 r4:c7836000
> Backtrace aborted due to bad frame pointer <c7837fbc>

Can you describe the conditions which leads up to this please?
