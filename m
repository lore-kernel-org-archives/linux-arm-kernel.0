From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 May 2014 11:25:45 +0200
Subject: [PATCH 05/17] pci: host: pcie-dra7xx: add support for pcie-dra7xx
 controller
In-Reply-To: <5369FB67.6040905@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <20140506163507.GA15542@obsidianresearch.com> <5369FB67.6040905@ti.com>
Message-ID: <5525000.bPgPLB3ZrT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 May 2014 14:52:47 Kishon Vijay Abraham I wrote:
> On Tuesday 06 May 2014 10:05 PM, Jason Gunthorpe wrote:
> > On Tue, May 06, 2014 at 07:03:51PM +0530, Kishon Vijay Abraham I wrote:
> >> +Example:
> >> +pcie at 51000000 {
> >> +    compatible = "ti,dra7xx-pcie";
> >> +    reg = <0x51002000 0x14c>, <0x51000000 0x2000>;
> >> +    reg-names = "ti_conf", "rc_dbics";
> >> +    interrupts = <0 232 0x4>, <0 233 0x4>;
> >> +    #address-cells = >;
> >> +    #size-cells = <2>;
> >> +    device_type = "pci";
> >> +    ti,device_type = >;
> >> +    ranges = <0x00000800 0 0x20001000 0x20001000 0 0x00002000  /* Configuration Space */
> > 
> > Configuration space should not show up in the ranges, please don't
> > copy that mistake from other drivers, put it in reg.
> 
> But then it needs pcie-designware.c to be modified and it will be breaking
> other platforms no?

I think the pcie-designware driver should be changed to allow either way.
Ideally we would deprecate the existing method in a way that for new front-ends
it doesn't work, but the old front-ends can still deal with it but also work
if you put it into the reg property.

	Arnd
