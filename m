From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Mar 2013 21:37:51 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321212236.1015295d@skate>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
Message-ID: <20130321203751.GP21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 09:22:36PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Thu, 21 Mar 2013 21:15:33 +0100, Andrew Lunn wrote:
> 
> > Could you recommend a document which introduces LPAE.
> > 
> > Only being able to address 7GB seems a bit odd to me. I kind of
> > expected you set up the translation tables to map a page in the 32 bit
> > address range to any arbitrary page in the 40 bit address range. So
> > leaving 0xC0000000 to 0xffffffff in the 32bit address range clear is
> > easy. But why do you loose space in the 40bit address range?
> 
> translation tables convert virtual addresses to physical addresses.
> Here, we are only talking about physical addresses. There is an overlap
> between the physical addresses used by the RAM, and the physical
> addresses at which I/O devices are visible.
> 
> And I'm not sure the SDRAM address decoding windows allows to split the
> first 4 GB of RAM into two areas, one that would be mapped starting at
> physical address 0x0, and another area that would be mapped at a
> different address (above 4 GB).

So why not map the whole SDRAM above 4GB physical address?

   Thanks
	Andrew
