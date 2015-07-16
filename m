From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Thu, 16 Jul 2015 07:27:34 +0000
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
In-Reply-To: <20150715160146.GS11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> > > > What is stacked mode?
> > > > ---------------------
> > > > ZynqMP GQSPI controller supports stacked mode with following
> > > functionalities:
> > > > 1) The Generic Quad-SPI controller also supports two SPI flash memories
> > > >    in a shared bus arrangement to reduce IO pin count.
> > > > 2) Separate chip select lines
> > > > 3) Shared I/O lines
> > > > 4) This mode is targeted for increasing the flash memory and no
> performance
> > > >    improvement when compared with single.
> 
> > > This is just a normal SPI controller from a SPI point of view.
> 
> > How can we really represent the stacked mode in current configuration?
> 
> In the same way as any other controller with two chip selects...  there are quite
> a few other drivers that provide examples of this, you should look for one that
> has hardware control similar to yours.

Thanks Mark for your suggestion. But I have minor doubts.

For an example take two flashes connected in stacked mode.
For user it doesn't matter whether how many flashes are really connected. 
There will be situation like, single partition is spread across two flashes (partition staring at the end of one flash and continued to the second flash). But it has to be shown contiguous to user.
In this scenario, I am not clear how MTD layer will handle the case.
It would be great if you could just put some light on it.

Regards,
Ranjit
