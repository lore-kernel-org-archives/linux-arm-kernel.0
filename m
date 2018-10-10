From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 10 Oct 2018 20:21:39 +0530
Subject: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
In-Reply-To: <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
 <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
Message-ID: <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-10-18, 08:48, Jordan Crouse wrote:
> qcom,level comes straight from:
> 
> https://lore.kernel.org/lkml/20180627045234.27403-2-rnayak at codeaurora.org/
> 
> But in this case instead of using the CPU to program the RPMh we are passing
> the value to a microprocessor (the GMU) and that will do the vote on our behalf
> (Technically we use the value to look up the vote in the cmd-db database and
> pass that to the GMU)
> 
> This is why the qcom,level was added in the first place so we could at least
> share the nomenclature with the rpmhd if not the implementation.

How you actually pass the vote to the underlying hardware, RPMh or
GMU, is irrelevant to the whole thing. What is important is how we
describe that in DT and how we represent the whole thing.

We have chosen genpd + OPP to do this and same should be used by you
as well. Another benefit is that the genpd core will do vote
aggregation for you here.

-- 
viresh
