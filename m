From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 22 Oct 2018 08:37:45 -0600
Subject: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
In-Reply-To: <20181022132027.GA15708@centauri.lan>
References: <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
 <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
 <20181010151006.GD9977@jcrouse-lnx.qualcomm.com>
 <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
 <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
 <20181015100327.qoojonf46lh6g3sh@vireshk-i7>
 <20181015143444.GA4751@jcrouse-lnx.qualcomm.com>
 <20181022103811.ywvyasnshjtdzjki@vireshk-i7>
 <20181022132027.GA15708@centauri.lan>
Message-ID: <20181022143745.GF26762@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2018 at 03:20:27PM +0200, Niklas Cassel wrote:
> On Mon, Oct 22, 2018 at 04:08:11PM +0530, Viresh Kumar wrote:
> > On 15-10-18, 08:34, Jordan Crouse wrote:
> > > I agree that consistency is good. But the GPU is by design outside of the
> > > control of the genpd universe so it is by design not using the same features.
> > > It unfortunately does happen to use a similar number in an OPP binding to
> > > construct the level mapping but since we can't read the cmd-db from the GMU
> > > space this is a necessary evil.
> > 
> > Where do you define how to use this binding in case of GPU? I mean
> > some DT binding doc must have some information to avoid confusion as
> > all other users will have the qcom,level thing in the genpd's OPP
> > table which GPU will have it directly within its OPP table.
> 
> Jordan suggested to use the RPMH_REGULATOR_LEVEL_* defines.
> These are defined in include/dt-bindings/power/qcom-rpmpd.h.
> 
> This header is only referenced in
> Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> (Which this patch series does not seem to use.)
> 
> This patch series does use
> Documentation/devicetree/bindings/opp/qcom-opp.txt
> but it does not reference include/dt-bindings/power/qcom-rpmpd.h.
> 
> So to further avoid confusion, perhaps it is better to create new
> defines, instead of reusing the RPMH_REGULATOR_LEVEL_* defines?

I would be fine with that. I'm also okay with using the raw values, but I
figure it would resolve Viresh's concerns if it was made clear that the
two use cases were using the same raw values. It would also help the GPU
folks visualize the expected level for each frequency entry.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
