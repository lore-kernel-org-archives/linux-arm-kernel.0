From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Aug 2011 18:52:51 +0100
Subject: [PATCH 1/6] ARM: highbank: add devicetree source
In-Reply-To: <4E4BC6F5.4030707@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-2-git-send-email-robherring2@gmail.com>
	<20110817072706.GE10037@S2100-06.ap.freescale.net>
	<4E4BC6F5.4030707@gmail.com>
Message-ID: <20110817175250.GM12686@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Aug 17, 2011 at 02:49:41PM +0100, Rob Herring wrote:
> In highbank.c:
> 
> +#define HB_JUMP_TABLE_PHYS(cpu)		(0x40 + (0x10 * (cpu)))
> +#define HB_JUMP_TABLE_VIRT(cpu)		phys_to_virt(HB_JUMP_TABLE_PHYS(cpu))
> +
> +void highbank_set_cpu_jump(int cpu, void *jump_addr)
> +{
> +	writel(BSYM(virt_to_phys(jump_addr)), HB_JUMP_TABLE_VIRT(cpu));
> +	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
> +	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
> +			  HB_JUMP_TABLE_PHYS(cpu) + 15);
> +}

I don't suppose you guys can boot on a CPU other than 0 can you? That would be
really handy for testing my cpu-mapping patch series :)

Will
