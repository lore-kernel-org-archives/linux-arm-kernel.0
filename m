From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 22 Apr 2016 15:23:25 +0200
Subject: [PATCH 10/11] arm64: tegra: Add clock properties on cpu0 for
 Tegra210
In-Reply-To: <571A0E95.9040203@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-11-git-send-email-pchiu@nvidia.com>
 <571A0E95.9040203@nvidia.com>
Message-ID: <20160422132325.GN9047@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 12:44:21PM +0100, Jon Hunter wrote:
> Hi Penny,
> 
> On 22/04/16 11:31, Penny Chiu wrote:
> > Add clocks, clock-names, and clock-latency into cpu0 node.
> > These properties will be used by cpufreq driver.
> > 
> > Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > index 204d9cd..1a85857 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > @@ -782,6 +782,12 @@
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a57";
> >  			reg = <0>;
> > +			clocks = <&tegra_car TEGRA210_CLK_CCLK_G>,
> > +				 <&tegra_car TEGRA210_CLK_PLL_X>,
> > +				 <&tegra_car TEGRA210_CLK_PLL_P_OUT4>,
> > +				 <&dfll>;
> > +			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
> > +			clock-latency = <300000>;
> >  		};
> >  
> >  		cpu at 1 {
> > 
> 
> Can you include a patch with this series to update the binding
> documentation for the nvidia,tegra124-cpufreq.txt? I think that although
> there is no specific nvidia,tegra210-cpufreq compatible string the
> documentation should state that both tegra124 and tegra210 are supported
> so it is clear.
> 
> Also I see the above binding no longer includes the "cpu_lp" for
> tegra210 which I understand we don't use here. However, the binding
> documentation should reflect this. Having said that, looking at the
> driver it appears the "cpu_lp" clock is not even used for tegra124. I
> wonder if we should drop this from the binding documentation and the
> tegra124.dtsi altogether?
> 
> What about the "vdd-cpu-supply" property? Don't we need this?

For some reason that seems to have moved into the clock at 70110000 node.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/0b020abe/attachment.sig>
