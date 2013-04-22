From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 21:18:41 +0200
Subject: [RFC PATCH v2 00/13] ARM: DT cpu bindings updates
In-Reply-To: <20130422180057.GB17071@e102568-lin.cambridge.arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130422164112.GB3076@mudshark.cambridge.arm.com>
 <20130422180057.GB17071@e102568-lin.cambridge.arm.com>
Message-ID: <201304222118.41262.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Lorenzo Pieralisi wrote:
> > Thoughts? I notice Catalin has some patches queued for arm64 which
> > unconditionally use of_property_read_u64, but I have a patch to honour the
> > #address-cells property instead.
> 
> Basically you want me to rule out passing a dtb with cpus node having
> #address-cells == 2 to a 32-bit kernel, correct ? Or put it another way:
> 
> - a 32-bit kernel must always get passed a dtb with cpus node
>   #address-cells == 1. 

Why that? For other registers, we allow leading zeroes. This is
already required for MMIO registers on LPAE capable machines.

>   If the system is ARMv8 with CPUs having
>   MPIDR_EL1[63:32] != 0x0, well, running 32-bit kernel on it is not
>   the safest thing to do anyway.

I would assume the hypervisor to provide a virtual MPIDR_EL1 for
a 32 bit kernel in that case.

	Arnd
