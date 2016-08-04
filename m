From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Aug 2016 13:13:06 +0200
Subject: Support for configurable PCIe endpoint
In-Reply-To: <57A31299.2040805@ti.com>
References: <57A18927.9070003@ti.com>
 <7c696488-eb78-d6d9-dc70-49fa5b4e3317@synopsys.com> <57A31299.2040805@ti.com>
Message-ID: <2422602.ltmdGR0pWX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 4, 2016 3:32:01 PM CEST Kishon Vijay Abraham I wrote:
> On Wednesday 03 August 2016 07:09 PM, Joao Pinto wrote:
> > 
> > You are rising a topic that we are also addressing in Synopsys.
> > 
> > For the PCIe RC hardware validation we are currently using the standard
> > pcie-designware and pcie-designware-plat drivers.
> > 
> > For the Endpoint we have to use an internal software package. Its main purpose
> > is to initialize the IP registers, eDMA channels and make data transfer to prove
> > that the everything is working properly. This is done in 2 levels, a custom
> > driver built and loaded and an application that makes some ioctl to the driver
> > executing some interesting functions to check the Endpoint status and make some
> > data exchange.
> 
> hmm.. the platform I have doesn't have a DMA in PCIe IP
> (http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf). So in your testing does the
> EP access RC memory? i.e the driver in the RC allocates memory from it's DDR
> and gives it's DDR address to the EP. The EP then transfers data to this
> address. (This is a typical use case with ethernet PCIe cards). IIUC that's not
> simple with configurable EPs. I'd like to know more about your testing though.


What's the difference between using the EDMA on that chip or a DMA engine
that is part of the PCIe bridge?

	Arnd
