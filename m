From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Jul 2015 11:56:45 +0100
Subject: "bus-cycles" perf event mapping
In-Reply-To: <20150718041037.GA19869@hp.com>
References: <20150718041037.GA19869@hp.com>
Message-ID: <20150721105644.GA22695@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 18, 2015 at 05:10:37AM +0100, ranganath ramachandra wrote:
> Hi,
> 
> Should PERF_COUNT_HW_BUS_CYCLES be mapped to ARMV8_PMUV3_PERFCTR_BUS_CYCLES
> or is there any specific reason for not doing so ?

I assume you're asknig about why it's not in armv8_pmuv3_perf_map?

We only list those events required by PMUv3, which are guaranteed to be
implemented by any PMUv3 compliant implementation.

While 0x1D / BUS_CYCLES has been allocated a common event number, it is
not required by PMUv3 and may not be implemented. In the latest ARM ARM
(ARM DDI 0487A.g) you can find the required events listed in D5.10.6
"Required events".

Thanks,
Mark.
