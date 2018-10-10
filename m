From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 10 Oct 2018 08:48:56 -0600
Subject: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
In-Reply-To: <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
 <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
Message-ID: <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 08:01:49PM +0530, Viresh Kumar wrote:
> On 10-10-18, 08:29, Jordan Crouse wrote:
> > On Wed, Oct 10, 2018 at 03:16:28PM +0530, Viresh Kumar wrote:
> > > On 27-08-18, 09:11, Jordan Crouse wrote:
> > > > Add the nodes to describe the Adreno GPU and GMU devices.
> > > > 
> > > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 121 +++++++++++++++++++++++++++
> > > >  1 file changed, 121 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > index cdaabeb3c995..10db0ceb3699 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > @@ -192,6 +192,59 @@
> > > >  		method = "smc";
> > > >  	};
> > > >  
> > > > +gpu_opp_table: adreno-opp-table {
> > > > +		compatible = "operating-points-v2-qcom-level";
> > > > +
> > > > +		opp-710000000 {
> > > > +			opp-hz = /bits/ 64 <710000000>;
> > > > +			qcom,level = <416>;
> > > 
> > > What is qcom,level here ? Is it different than the RPM voting thing ?
> > > 
> > > If not then you need to follow what Rajendra, Niklas are doing as
> > > well. There needs to be a genpd which needs to carry this value and
> > > the gpu's table will have required-opps entry to point to it.
> > 
> > I don't think it is the same (we have some special considerations here)
> > but I missed the new work from the other folks and I want to review it
> > before I conclude one way or the other. Is there a link to the latest
> > and greatest that I can use to get caught up?
> 
> lkml.kernel.org/r/20180627045234.27403-1-rnayak at codeaurora.org
> 
> +Rajendra/Niklas, please review Jordan's work as well to see if the
> qcom,level thing is similar to what you guys are using.

qcom,level comes straight from:

https://lore.kernel.org/lkml/20180627045234.27403-2-rnayak at codeaurora.org/

But in this case instead of using the CPU to program the RPMh we are passing
the value to a microprocessor (the GMU) and that will do the vote on our behalf
(Technically we use the value to look up the vote in the cmd-db database and
pass that to the GMU)

This is why the qcom,level was added in the first place so we could at least
share the nomenclature with the rpmhd if not the implementation.

Jordan

> -- 
> viresh
> _______________________________________________
> Freedreno mailing list
> Freedreno at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
