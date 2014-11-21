From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Nov 2014 17:41:42 +0100
Subject: [PATCHv3 09/16] ARM: mvebu: implement suspend/resume support for
 Armada XP
In-Reply-To: <1416585613-2113-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1416585613-2113-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141121164142.GB20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void mvebu_pm_store_bootinfo(void)
> +{
> +	u32 *store_addr;
> +	phys_addr_t resume_pc;
> +
> +	store_addr = phys_to_virt(BOOT_INFO_ADDR);
> +	resume_pc = virt_to_phys(armada_370_xp_cpu_resume);
> +
> +	/*
> +	 * The bootloader expects the first two words to be a magic
> +	 * value (BOOT_MAGIC_WORD), followed by the address of the
> +	 * resume code to jump to. Then, it expects a sequence of
> +	 * (address, value) pairs, which can be used to restore the
> +	 * value of certain registers. This sequence must end with the
> +	 * BOOT_MAGIC_LIST_END magic value.
> +	 */

Hi Thomas

Is this a well defined mechanism supported by mainline uboot, barebox
etc. Or is it some Marvell extension to their uboot?

     Thanks
	Andrew
