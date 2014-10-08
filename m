From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 8 Oct 2014 11:06:31 -0500
Subject: [PATCH 2/4] ARM: qcom: add description of KPSS WDT for IPQ8064
In-Reply-To: <5434723F.70800@codeaurora.org>
References: <cover.1412182773.git.joshc@codeaurora.org>
 <50c0ec1514173ce07641a95839e939dcda41b110.1412182773.git.joshc@codeaurora.org>
 <20141001172855.GL10233@codeaurora.org>
 <20141001181557.GQ868@joshc.qualcomm.com>
 <542DA2B6.3020201@codeaurora.org>
 <20141007221044.GR868@joshc.qualcomm.com>
 <5434723F.70800@codeaurora.org>
Message-ID: <20141008160631.GT868@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 04:07:43PM -0700, Stephen Boyd wrote:
> On 10/07/2014 03:10 PM, Josh Cartwright wrote:
> >On Thu, Oct 02, 2014 at 12:08:38PM -0700, Stephen Boyd wrote:
[..]
> >>I'm thinking:
> >>
> >>                 timer at 200a000 {
> >>                         compatible = "qcom,kpss-timer", "qcom,msm-timer";
> >>                         interrupts = <1 1 0x301>,
> >>                                      <1 2 0x301>,
> >>                                      <1 3 0x301>,
> >>                                      <1 4 0x301>,
> >>                                      <1 5 0x301>;
> >>                         reg = <0x0200a000 0x100>;
> >>                         clock-frequency = <27000000>,
> >>                                           <32768>;
> >>                         clocks = <&cxo>, <&sleep_clk>;
> >>                         clock-names = "ref", "sleep";
> >>                         cpu-offset = <0x80000>;
> >>                 };
> >Where'd the default timeout configuration go?  Or, should we have one
> >timeout-sec property and not allow setting the default timeouts per WDT
> >instance?  Or no configurable timeout at all?
> 
> Ah sorry. How about a timeout-sec-0, timeout-sec-1 property that is per-cpu
> and maps to the first and second watchdog timer? Something like:
> 
> timeout-sec-wdt0 = <10 8>;
> timeout-sec-wdt1 = <20 15>;

Okay, yeah, this is much more concise.  I'll take a stab at implementing
it.

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
