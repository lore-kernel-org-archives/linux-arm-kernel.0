From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 00:57:35 +0200
Subject: [PATCHv2] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <1350581567-17229-1-git-send-email-dinguyen@altera.com>
References: <1350581567-17229-1-git-send-email-dinguyen@altera.com>
Message-ID: <20121025005735.35b9f971@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear dinguyen at altera.com,

On Thu, 18 Oct 2012 11:32:47 -0600, dinguyen at altera.com wrote:

> +static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> +
> +	memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
> +
> +	__raw_writel(virt_to_phys(secondary_startup), (sys_manager_base_addr+0x10));
> +
> +	pen_release = 0;

Are you sure that this code builds? In your v1, this variable was
declared in your assembly file, but it is no longer here, and you
mention in your changelog that it has been removed. But not completely
apparently.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
