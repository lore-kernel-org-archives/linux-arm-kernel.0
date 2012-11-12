From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2012 09:52:31 +0000
Subject: [PATCH v3 6/6] ARM: EXYNOS: Add secure firmware support to
 secondary CPU bring-up
In-Reply-To: <1351178560-19188-7-git-send-email-t.figa@samsung.com>
References: <1351178560-19188-1-git-send-email-t.figa@samsung.com>
 <1351178560-19188-7-git-send-email-t.figa@samsung.com>
Message-ID: <20121112095231.GE28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 05:22:40PM +0200, Tomasz Figa wrote:
> @@ -47,6 +48,8 @@ static inline void __iomem *cpu_boot_reg(int cpu)
>  {
>  	void __iomem *boot_reg;
>  
> +	if (!call_firmware_op(cpu_boot_reg, cpu, &boot_reg))
> +		return boot_reg;
>  	boot_reg = cpu_boot_reg_base();

That code makes no sense.
