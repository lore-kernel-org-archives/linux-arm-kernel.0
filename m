From: nm@ti.com (Nishanth Menon)
Date: Wed, 13 Jun 2018 08:32:15 -0500
Subject: [PATCH 2/4] ARM: Introduce ability to enable invalidate of BTB
 with ICIALLU on Cortex-A15 for CVE-2017-5715
In-Reply-To: <8fac2f1c-ecc4-1aa1-0620-8ac6e2efdbf1@gmail.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-3-nm@ti.com>
 <8fac2f1c-ecc4-1aa1-0620-8ac6e2efdbf1@gmail.com>
Message-ID: <20180613133215.2cv7iyjb2laaha3j@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:05-20180612, Marek Vasut wrote:
> On 06/12/2018 10:24 PM, Nishanth Menon wrote:
[..]
> > +#ifdef CONFIG_ARM_CORTEX_A15_CVE_2017_5715
> > +	mrc	p15, 0, r0, c1, c0, 1	@ read auxilary control register
> > +	orr	r0, r0, #1 << 0		@ Enable invalidates of BTB
> 
> Can we use BIT() macro in the assembler code too ?

Probably, but just following convention in the rest of the file. Do we
want to change from existing code?

-- 
Regards,
Nishanth Menon
