From: stelford@cadence.com (Scott Telford)
Date: Fri, 3 Aug 2018 14:46:39 +0000
Subject: [PATCH v2] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
In-Reply-To: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
References: <201807191323.JVEjlMdZ%fengguang.wu@intel.com>
 <1532090477-15559-1-git-send-email-stelford@cadence.com>
 <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
Message-ID: <BYAPR07MB44854DCEA5537DA2D20DC7F0CF230@BYAPR07MB4485.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: 24 July 2018 04:57
> To: Scott Telford <stelford@cadence.com>; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; Damian Kos <dkos@cadence.com>
> Subject: Re: [PATCH v2] phy: Add driver for Cadence MHDP DisplayPort
> SD0801 PHY
> 
[..]
> > +static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy
> *cdns_phy)
> > +{
> > +	/* refclock registers - assumes 25 MHz refclock */
> > +	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
> > +	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
> > +	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
> > +	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
> > +	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
> > +	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
> > +	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
> > +	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
> > +	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
> > +	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
> > +	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
> > +	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
> > +	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
> > +	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
> > +	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
> > +	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
> > +	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
> > +	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
> > +	/* PLL registers */
> > +	writel(0x0409, cdns_phy->sd_base +
> CMN_PDIAG_PLL0_CP_PADJ_M0);
> > +	writel(0x1001, cdns_phy->sd_base +
> CMN_PDIAG_PLL0_CP_IADJ_M0);
> > +	writel(0x0F08, cdns_phy->sd_base +
> CMN_PDIAG_PLL0_FILT_PADJ_M0);
> > +	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
> > +	writel(0x00FA, cdns_phy->sd_base +
> CMN_PLL0_VCOCAL_INIT_TMR);
> > +	writel(0x0004, cdns_phy->sd_base +
> CMN_PLL0_VCOCAL_ITER_TMR);
> > +	writel(0x00FA, cdns_phy->sd_base +
> CMN_PLL1_VCOCAL_INIT_TMR);
> > +	writel(0x0004, cdns_phy->sd_base +
> CMN_PLL1_VCOCAL_ITER_TMR);
> > +	writel(0x0318, cdns_phy->sd_base +
> CMN_PLL0_VCOCAL_REFTIM_START);
> 
> Are these values that are written just calibration data or are they bitfields
> for a specific setting. If they are not calibration data, then macros should be
> added. 

These are calibration values.

I will post a new revision addressing your other comments shortly.

Regards,
Scott.
