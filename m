From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 22 Oct 2018 16:08:11 +0530
Subject: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
In-Reply-To: <20181015143444.GA4751@jcrouse-lnx.qualcomm.com>
References: <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
 <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
 <20181010151006.GD9977@jcrouse-lnx.qualcomm.com>
 <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
 <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
 <20181015100327.qoojonf46lh6g3sh@vireshk-i7>
 <20181015143444.GA4751@jcrouse-lnx.qualcomm.com>
Message-ID: <20181022103811.ywvyasnshjtdzjki@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-10-18, 08:34, Jordan Crouse wrote:
> I agree that consistency is good. But the GPU is by design outside of the
> control of the genpd universe so it is by design not using the same features.
> It unfortunately does happen to use a similar number in an OPP binding to
> construct the level mapping but since we can't read the cmd-db from the GMU
> space this is a necessary evil.

Where do you define how to use this binding in case of GPU? I mean
some DT binding doc must have some information to avoid confusion as
all other users will have the qcom,level thing in the genpd's OPP
table which GPU will have it directly within its OPP table.

-- 
viresh
