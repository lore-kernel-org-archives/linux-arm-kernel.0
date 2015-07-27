From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Mon, 27 Jul 2015 13:55:56 +0000
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
In-Reply-To: <20150724105209.GI11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150716085739.GT11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA81D12@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150724105209.GI11162@sirena.org.uk>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3C0148C95C@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Friday, July 24, 2015 4:22 PM
> To: Ranjit Abhimanyu Waghmode
> Cc: Michal Simek; Soren Brinkmann; zajec5 at gmail.com; marex at denx.de;
> shijie.huang at intel.com; juhosg at openwrt.org; ben at decadent.org.uk; linux-
> mtd at lists.infradead.org; linux-spi at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Harini Katakam;
> Punnaiah Choudary Kalluri; ran27jit at gmail.com; dwmw2 at infradead.org;
> computersforpeace at gmail.com
> Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
> Zynq MPSoC GQSPI controller
> 
> On Fri, Jul 24, 2015 at 10:42:35AM +0000, Ranjit Abhimanyu Waghmode wrote:
> 
> As I think you've been asked before please fix your mail client to word wrap
> within paragraphs so your mails are more legible.
> 

Sorry about this, I did some changes but it's kind of broken. Will fix this.

> > To support the dual parallel mode in this controller, following minor
> > things can be added to the driver.
> 
> > 1) Controller needs to know in which mode it is working, then it's
> > obvious to set the appropriate flag for the same
> > 2) There are more than one chip selects, so need to set the same
> >
> > So kindly suggest your view on the above request.
> 
> I'm not entirely sure what you're asking here from the point of view of SPI, sorry
> - what exactly are you requesting?  If you want to add support for new SPI bus
> modes please go ahead and do that, you need to clearly document what any
> new modes you're adding are so that other people can understand them.

Ok, my description was too short to get it completely.

For adding dual parallel mode support to current driver:
Are following points enough? Or do you want to suggest something better on top of it?

Driver:
1) Controller needs to know in which mode it is working.
2) As there are more than one chip selects, may need to add code for handling that as well.

MTD:
1) Adding TWO_FLASH support
2) Adding DATA_STRIPE support
3) For reading array size needs to be doubled.
4) Need to access even addresses. Basically address/2.

Please suggest your view on above points.

Regards,
Ranjit
