From: TWarren@nvidia.com (Tom Warren)
Date: Mon, 26 Oct 2015 21:36:33 +0000
Subject: [PATCH v3] Tegra: DT: add device tree binding doc for QSPI
In-Reply-To: <562E954B.5070604@wwwdotorg.org>
References: <1445891676-3262-1-git-send-email-twarren@nvidia.com>
 <562E954B.5070604@wwwdotorg.org>
Message-ID: <731fc53aa2d24edc93c2af43a7711657@HQMAIL104.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

> -----Original Message-----
> From: Stephen Warren [mailto:swarren at wwwdotorg.org]
> Sent: Monday, October 26, 2015 2:04 PM
> To: Tom Warren <TWarren@nvidia.com>
> Cc: u-boot at lists.denx.de; Stephen Warren <swarren@nvidia.com>;
> tomcwarren3959 at gmail.com; jteki at openedev.com; robh+dt at kernel.org;
> pawel.moll at arm.com; mark.rutland at arm.com; ijc+devicetree at hellion.org.uk;
> galak at codeaurora.org; Thierry Reding <treding@nvidia.com>; linux-
> tegra at vger.kernel.org; Alex Courbot <acourbot@nvidia.com>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3] Tegra: DT: add device tree binding doc for QSPI
> 
> On 10/26/2015 02:34 PM, Tom Warren wrote:
> > This patch adds the device tree binding doc for the Tegra QSPI
> > controller on Tegra210.
> 
> > diff --git
> > a/Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
> > b/Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
> 
> > +- clock-names : Must include the following entries:
> > +  - qspi
> > +- resets : Must contain an entry for each entry in reset-names.
> > +  See ../reset/reset.txt for details.
> > +- reset-names : Must include the following entries:
> > +  - qspi
> > +- clocks : Must contain an entry for each entry in clock-names.
> > +  See ../clocks/clock-bindings.txt for details.
> 
> Let's keep clocks and clock-names next to each-other in the doc. I don't know
> why they aren't in the eixsting Tegra SPI doc.
OK. I assume 'clock-names', then 'clocks' since 'clocks' references clock-names.

> 
> With this issue fixed, this patch looks good to me.
> 
> Note: I don't see the devicetree mailing list in the CC list. You should probably
> replace the U-Boot mailing list with it.
I thought I had it, but may have dropped it. What exactly is the URL of the devicetree mailing list? devicetree-discuss at lists.ozlabs.org? or devicetree at vger.kernel.org?

> 
> > +Optional properties:
> > +- dmas : Must contain an entry for each entry in clock-names.
> > +  See ../dma/dma.txt for details.
> > +- dma-names : Must include the following entries:
> > +  - rx
> > +  - tx
> 
> Eventually, we should have a property that describes the SPI bus width (x1, x2,
> x4 I assume). However, we can assume that unless otherwise specified, the
> width is x1, and add a property to specify the width later as/when we need it if
> you want.

Tom
--
nvpublic
