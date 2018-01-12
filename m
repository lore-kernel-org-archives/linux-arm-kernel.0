From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Jan 2018 17:38:02 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <VI1PR04MB2078DBC9381EA574CE5DA4B09A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180109214332.ejiak6f35tnhbpke@pd.tnic>
 <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <bc8d7450-3f58-95c2-42c2-d16b2f7a76e4@linux.intel.com>
 <VI1PR04MB20786CC3E2981C0F60E095079A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112171251.4ricaz3lzditr7pi@pd.tnic>
 <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
Message-ID: <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 05:17:54PM +0000, York Sun wrote:
> On 01/12/2018 09:13 AM, Borislav Petkov wrote:
> > On Fri, Jan 12, 2018 at 04:48:05PM +0000, York Sun wrote:
> >> I see Stratix10 has A53 core. I am concerned on reading the
> >> CPUMERRSR_EL1 and L2MERRSR_EL1. The are IMPLEMENTATION DEFINED
> >> registers. They may not be available on all SoCs, or all time.
> > 
> > Is there something like CPUID on x86, on ARM64 which denotes presence of
> > a certain feature?
> > 
> > Or is that thing devicetree?
> 
> This feature is available on the SoC I am working on (NXP LS1046A). It
> seems always there. I don't know if there is any register denoting the
> existence of such feature.

There is no architectural register describing this.

Judging by the Cortex-A53 TRM, there is no IMP DEF / auxilliary register
describing this.

Regardless, a DT binding is necessary due to potential interactions with
FW, hypervisors, etc.

> I guess we can use device tree if this feature exists. Not sure if
> big.LITTLE is a concern here.

There are big.LITTLE systems with Cortex-A53, so we definitely care
about big.LITTLE here.

Thanks,
Mark.
