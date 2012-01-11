From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 11 Jan 2012 17:45:47 +0900
Subject: ARM kexec SMP problem using exynos4210
Message-ID: <4F0D4C3B.80208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have tested kexec to Nuri board using Exynos4210(Dual-core ARM
Cortex-A9) on the latest mainline kernel but i am facing one problem.

The kernel enabled SMP, kernel_kexec() calls machine_shutdown to stop
all cpus except current cpu and jumps to the new kernel but the kernel
is hanged soon.

I used cpu_down(1) to make disabled cpu1 instead of smp_send_stop of
machine_shutdown and it is booted successfully to new kernel.

Any ideas?

Thanks.
