From: alvin.chen@intel.com (Chen, Alvin)
Date: Wed, 8 Oct 2014 01:32:09 +0000
Subject: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <1411981378.11022.1.camel@linux.intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
 <1411981378.11022.1.camel@linux.intel.com>
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E997C63@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The SPI memory mapped I/O registers supported by Quark are different
> > from the current implementation, and Quark only supports the registers
> > of 'SSCR0', 'SSCR1', 'SSSR', 'SSDR', and 'DDS_RATE'. This patch is to
> > enable the SPI for Intel Quark X1000.
> >
> > This piece of work is derived from Dan O'Donovan's initial work for
> > Intel Quark
> > X1000 SPI enabling.
> 
> Minor comments are below.
> 
> After addressing them
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
OK.
> > +	case QUARK_X1000_SSP:
> > +		return RX_THRESH_QUARK_X1000_DFLT;
> >  	default:
> >  		return RX_THRESH_DFLT;
> >  	}
> > +
> 
> Redundant empty line.
> 
OK. I will remove it.

> >  static void pxa2xx_spi_clear_rx_thre(const struct driver_data *drv_data,
> > -				     u32 *sccr1_reg)
> > +					  u32 *sccr1_reg)
> 
> Unnecessary change.
> 
Improve it in the first patch.
> >  static void pxa2xx_spi_set_rx_thre(const struct driver_data *drv_data,
> > -				   u32 *sccr1_reg, u32 threshold)
> > +					u32 *sccr1_reg, u32 threshold)
> 
> Ditto.
> 
> Or you may do that in the first patch.
> 
Improve it in the first patch.
> >
> >  			pxa2xx_spi_set_rx_thre(drv_data, &sccr1_reg,
> > -					       rx_thre);
> > +						    rx_thre);
> 
> Ditto.
> 
Improve it in the first patch.
> > +	if (is_quark_x1000_ssp(drv_data) &&
> > +	    (read_DDS_RATE(reg) != chip->dds_rate))
> 
> Could it be one line?
> 
No, it is beyond 80 characters if it is in one line.
