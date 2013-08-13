From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 13 Aug 2013 14:58:35 -0500
Subject: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <520A8E71.4090508@wwwdotorg.org>
References: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
 <520A8E71.4090508@wwwdotorg.org>
Message-ID: <1376423915.3167.2.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-13 at 13:52 -0600, Stephen Warren wrote:
> On 08/12/2013 09:49 AM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> > Add "syscon" to the "altr,sys-mgr" binding.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> I think it's reasonable to define one binding as being based on another
> plus some additions, so, the binding,
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks Stephen!
> 
> > +Example:
> > +	dwmmc0 at ff704000 {
> > +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> > +		altr,dw-mshc-sdr-timing = <0 3>;
> > +	};
> 
> It'd be nice to provide a complete example though, rather than only
> including the properties that this binding adds to the base binding.

I'll add a complete binding.
> 
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> 
> >  		sysmgr at ffd08000 {
> > -				compatible = "altr,sys-mgr";
> > +				compatible = "altr,sys-mgr", "syscon";
> 
> That seems like an unrelated change?

This patch is to enable SD/MMC for SOCFPGA. The "syscon" is needed in
dw_mmc-socfpga.c as the clock phases for the SD IP is controlled by
registers in "altr,sys-mgr".

Thanks,

Dinh
> 
