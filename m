From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 10 Oct 2018 20:01:49 +0530
Subject: [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu device nodes
In-Reply-To: <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
 <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
Message-ID: <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-10-18, 08:29, Jordan Crouse wrote:
> On Wed, Oct 10, 2018 at 03:16:28PM +0530, Viresh Kumar wrote:
> > On 27-08-18, 09:11, Jordan Crouse wrote:
> > > Add the nodes to describe the Adreno GPU and GMU devices.
> > > 
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 121 +++++++++++++++++++++++++++
> > >  1 file changed, 121 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index cdaabeb3c995..10db0ceb3699 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -192,6 +192,59 @@
> > >  		method = "smc";
> > >  	};
> > >  
> > > +gpu_opp_table: adreno-opp-table {
> > > +		compatible = "operating-points-v2-qcom-level";
> > > +
> > > +		opp-710000000 {
> > > +			opp-hz = /bits/ 64 <710000000>;
> > > +			qcom,level = <416>;
> > 
> > What is qcom,level here ? Is it different than the RPM voting thing ?
> > 
> > If not then you need to follow what Rajendra, Niklas are doing as
> > well. There needs to be a genpd which needs to carry this value and
> > the gpu's table will have required-opps entry to point to it.
> 
> I don't think it is the same (we have some special considerations here)
> but I missed the new work from the other folks and I want to review it
> before I conclude one way or the other. Is there a link to the latest
> and greatest that I can use to get caught up?

lkml.kernel.org/r/20180627045234.27403-1-rnayak at codeaurora.org

+Rajendra/Niklas, please review Jordan's work as well to see if the
qcom,level thing is similar to what you guys are using.

-- 
viresh
