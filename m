From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 12:54:26 +0100
Subject: [PATCH 05/10] ARM: tegra: Add Tegra114 DSI support
In-Reply-To: <52B34FC2.5010409@wwwdotorg.org>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
 <1387468774-14216-6-git-send-email-treding@nvidia.com>
 <52B34FC2.5010409@wwwdotorg.org>
Message-ID: <20131220115426.GO27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 12:57:54PM -0700, Stephen Warren wrote:
> On 12/19/2013 08:59 AM, Thierry Reding wrote:
> > Add device tree nodes for the DSI controllers found on Tegra114 SoCs.
> 
> > diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> 
> > +		dsi at 54300000 {
> > +			compatible = "nvidia,tegra114-dsi";
> > +			reg = <0x54300000 0x00040000>;
> > +			clocks = <&tegra_car TEGRA114_CLK_DSIA>,
> > +				 <&tegra_car TEGRA114_CLK_DSIALP>,
> > +				 <&tegra_car TEGRA114_CLK_PLL_D_OUT0>;
> > +			clock-names = "dsi", "lp", "parent";
> 
> The binding document
> Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt doesn't
> mention an "lp" clock:
> 
>   - clock-names: Must include the following entries:
>     - dsi
>       This MUST be the first entry.
>     - parent
> 
> I assume this is simply an oversight, since this is an obvious extension
> of the binding, and that the DT binding will be updated to include that
> clock in the list, and hence won't block applying the series because of
> this.

Yes, that was merely an oversight. I've updated the DT binding to
include the lp clock.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/95b2315e/attachment.sig>
