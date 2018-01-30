From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Jan 2018 01:48:16 -0800
Subject: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <514c49cc-71f9-ee21-250a-04f8fab151c0@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180126221501.GD28313@codeaurora.org>
 <514c49cc-71f9-ee21-250a-04f8fab151c0@codeaurora.org>
Message-ID: <20180130094816.GJ28313@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29, Rajendra Nayak wrote:
> 
> 
> On 01/27/2018 03:45 AM, Stephen Boyd wrote:
> > On 01/25, Rajendra Nayak wrote:
> >>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> >>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
> > 
> > Do we really need two files? Maybe collapse the two?
> 
> will do. Not sure why, but this is how all other qualcomm
> boards are structured with an almost empty .dts file.

I think it's because we have v1, v2, v3, etc. when we're sorting
out the versions of silicon, but then those are all dropped when
everything is done. Upstream we probably never care.

> >> +
> >> +				core2 {
> >> +					cpu = <&CPU6>;
> >> +				};
> >> +
> >> +				core3 {
> >> +					cpu = <&CPU7>;
> >> +				};
> >> +			};
> >> +		};
> > 
> > From what I recall, this layout causes the kernel to spew
> > warnings? I mean to say this is the power/performance view, but
> > not the architectural view.
> 
> hmm, I haven't seen any warnings with this when I boot up on my sdm845
> MTP. Will recheck.

Ok! I will recheck as well.

> 
> > 
> >> +	};
> >> +
> >> +	timer {
> >> +		compatible = "arm,armv8-timer";
> >> +		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > 
> > Are we supposed to use the GIC_CPU_MASK_SIMPLE macros still?
> 
> Not sure, is there another way?

Me either. See this thread from Marc[1]. I guess just drop them?

[1] http://lkml.iu.edu/hypermail/linux/kernel/1702.0/03522.html
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
