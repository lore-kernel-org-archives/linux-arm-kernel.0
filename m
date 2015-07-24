From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Fri, 24 Jul 2015 10:42:35 +0000
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150716085739.GT11162@sirena.org.uk>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA81D12@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> > > For an example take two flashes connected in stacked mode.
> > > For user it doesn't matter whether how many flashes are really connected.
> > > There will be situation like, single partition is spread across two
> > > flashes
> > (partition staring at the end of one flash and continued to the second
> > flash). But it has to be shown contiguous to user.
> > > In this scenario, I am not clear how MTD layer will handle the case.
> > > It would be great if you could just put some light on it.
> >
> > That's something for the MTD layer or possibly even a layer above it
> > to worry about - this situation is the same as we have with disks
> > where we have md which combines other devices, if something similar is
> > needed for flash we should use a similar pattern.

To support the dual parallel mode in this controller, following minor things can be added to the driver.
1) Controller needs to know in which mode it is working, then it's obvious to set the appropriate flag for the same
2) There are more than one chip selects, so need to set the same

And for supporting the same dual parallel mode, MTD layer may need to update for:
1) Adding TWO_FLASH support
2) Adding DATA_STRIPE support
3) For reading array size needs to be doubled.
4) Need to access even addresses. Basically address/2.

So kindly suggest your view on the above request.

Regards,
Ranjit

> 
> Kindly help in understanding, how can we represent the stacked mode and
> parallel mode changes in MTD layer?
> 
> Thanks & Regards,
> Ranjit
