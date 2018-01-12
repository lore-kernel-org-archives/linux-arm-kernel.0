From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Jan 2018 17:23:33 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <20180112171251.4ricaz3lzditr7pi@pd.tnic>
References: <VI1PR04MB2078DBC9381EA574CE5DA4B09A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180109214332.ejiak6f35tnhbpke@pd.tnic>
 <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <bc8d7450-3f58-95c2-42c2-d16b2f7a76e4@linux.intel.com>
 <VI1PR04MB20786CC3E2981C0F60E095079A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112171251.4ricaz3lzditr7pi@pd.tnic>
Message-ID: <20180112172333.ys7jovpdavof43vs@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 06:12:51PM +0100, Borislav Petkov wrote:
> On Fri, Jan 12, 2018 at 04:48:05PM +0000, York Sun wrote:
> > I see Stratix10 has A53 core. I am concerned on reading the
> > CPUMERRSR_EL1 and L2MERRSR_EL1. The are IMPLEMENTATION DEFINED
> > registers. They may not be available on all SoCs, or all time.
> 
> Is there something like CPUID on x86, on ARM64 which denotes presence of
> a certain feature?
> 
> Or is that thing devicetree?

We have ID registers, like CPUID, but for various reasons those aren't
sufficient to guarantee that IMPLEMENTATION DEFINED features can be
used.

If we want to support this, we'd certainly need something in DT.

For ACPI systems I'd expect this to be hidden behind APEI or similar,
with the kernel staying well clear of these registers.

Thanks,
Mark.
