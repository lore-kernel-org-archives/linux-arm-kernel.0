From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 4 Jul 2016 12:36:05 +0000
Subject: [RFC PATCH v2 2/4] net: ethernet: xilinx: Add gmii2rgmii
 converter support
In-Reply-To: <577A572F.1050004@atmel.com>
References: <1467623084-15471-1-git-send-email-appanad@xilinx.com>
 <1467623084-15471-3-git-send-email-appanad@xilinx.com>
 <577A323A.4080207@atmel.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A5BB227@XAP-PVEXMBX01.xlnx.xilinx.com>
 <577A572F.1050004@atmel.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5BB285@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,


> >
> > #ifdef CONFIG_NET_VENDOR_XILINX
> 
> You may need to have:
> #if defined(CONFIG_NET_VENDOR_XILINX) &&
> defined(CONFIG_XILINX_GMII2RGMII)
> 
> >  extern int gmii2rgmii_phyprobe(struct gmii2rgmii *xphy); #else extern
> > void gmii2rgmii_phyprobe(struct gmii2rgmii *xphy);
> 
> No need for the line above...
> 
> > void gmii2rgmii_phyprobe(struct gmii2rgmii *xphy) { }
> 
> On one single line, like:
> 
> static inline void gmii2rgmii_phyprobe(struct gmii2rgmii *xphy) { }
> 
> > #endif
> > For me the changes are looking odd...
> 
> For me, it's okay...

Ok will fix as you suggested...

> 
> >
> > Other possible ways
> > 	1)  Put a config check around phyprobe api in the macb driver.
> > #ifdef CONFIG_XILINX_GMII2RGMII
> >                        gmii2rgmii_phyprobe(&bp->converter_phy);
> > #endif
> 
> Nope!
> 
> > 	2) Select NET_VENDOR_XILINX in the macb Kconfig @ -22,6 +22,7 @@
> > config MACB
> >         tristate "Cadence MACB/GEM support"
> >         depends on HAS_DMA
> >         select PHYLIB
> > +       select NET_VENDOR_XILINX
> 
> 
> 
> > Please let me know which one you prefer will fix that and will post v3...
> 
> First one with my changes is the best. But maybe wait for more feedback...

Ok sure will wait and will post next version with your suggestion in case of no comments...

Regards,
Kedar.

> 
> Bye,
> --
> Nicolas Ferre
