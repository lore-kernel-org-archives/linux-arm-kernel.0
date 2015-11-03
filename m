From: slash.tmp@free.fr (Mason)
Date: Tue, 3 Nov 2015 20:52:30 +0100
Subject: Cortex-A9 SCU + ARM_ERRATA_764369
In-Reply-To: <20151103172743.GE4049@leverpostej>
References: <5638E61C.30406@free.fr> <20151103172743.GE4049@leverpostej>
Message-ID: <5639107E.7030901@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland wrote:

> Mason wrote:
>
>> What is scu_base + 0x30? (SCU diagnostic control register?)
> 
> It's documented (admittedly very sparsely) in the Software
> Developers Errata Notice for Cortex-A9 processors, in the
> section regarding erratum 764369.

A Freescale document mentions:

> Set bit[0] in the undocumented SCU diagnostic control register
> located at offset 0x30 from the PERIPHBASE address. Setting this bit
> disables the "migratory bit" feature. This forces a dirty cache line
> to be evicted to the lower memory subsystem?which is both the point
> of coherency and the point of unification?when it is being read by
> another processor.

Can this register be written to by a non-secure OS?

Regards.
