From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jan 2012 11:03:20 +0000
Subject: ARM kexec SMP problem using exynos4210
In-Reply-To: <4F0D6316.4090800@samsung.com>
References: <4F0D49DD.80305@samsung.com>
 <20120111100623.GA27887@mudshark.cambridge.arm.com>
 <4F0D6316.4090800@samsung.com>
Message-ID: <20120111110319.GB27887@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 10:23:18AM +0000, Joonyoung Shim wrote:
> One more question, generally boot cpu is first cpu(cpu0). If current
> cpu is secondary cpu(cpu1), smp_send_stop of machine_shutdown will stop
> first cpu and next kernel will try to boot on secondary cpu. Is it
> possible?

I added the cpu_logical_map stuff for this, so the kernel can handle it.
That said, your platform may have restrictions about the boot CPU so if it
doesn't work, you'll need to taskset the kexec command to CPU 0.

Will
