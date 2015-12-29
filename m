From: marex@denx.de (Marek Vasut)
Date: Tue, 29 Dec 2015 14:33:16 +0100
Subject: [PATCH] doc: PCI: altera: Fix the 'ranges' property in example
In-Reply-To: <1451375313.2990.8.camel@ubuntu>
References: <1450950330-28393-1-git-send-email-marex@denx.de>
 <201512280926.53004.marex@denx.de> <1451375313.2990.8.camel@ubuntu>
Message-ID: <201512291433.16561.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 29, 2015 at 08:48:33 AM, Ley Foon Tan wrote:
> On Mon, 2015-12-28 at 09:26 +0100, Marek Vasut wrote:
> > On Monday, December 28, 2015 at 08:42:00 AM, Ley Foon Tan wrote:
> > > On Mon, Dec 28, 2015 at 3:34 PM, Marek Vasut <marex@denx.de> wrote:
> > > > On Monday, December 28, 2015 at 07:56:15 AM, Ley Foon Tan wrote:
> > > >> On Thu, 2015-12-24 at 10:45 +0100, Marek Vasut wrote:
> > > >> > The example does not work on real hardware with the PCIe HIP [1].
> > > >> > The problem is with incorrect "ranges" property in the example, so
> > > >> > one cannot just copy-paste the example into his DT and expect this
> > > >> > to work. This patches aligns the "ranges" in the example with the
> > > >> > reference FPGA design.
> > > >> 
> > > >> Hi Marek
> > > > 
> > > > Hi Ley,
> > > > 
> > > >> The original "ranges" is working for me. What error did you
> > > >> encounter?
> > > > 
> > > > Every time a driver accessed the Txs range, the system got stuck
> > > > hard. The Cra access always worked fine though, so the PCIe devices
> > > > were always detected.
> > > > 
> > > > I checked with signaltap and my impression is that the wrong address
> > > > propagated into the request passed to the Txs port of the HardIP
> > > > block, unless I change the range configuration.
> > > > 
> > > > Note that I tested Intel Centrino 6235 WiFi card and Atheros AR5006
> > > > WiFi card. The intel in particular uses both the Txs and even MSI ,
> > > > so to use the intel, the whole PCIe block has to work properly ;
> > > > with this change, it does and I can use the intel card just fine.
> > > > 
> > > >> Thanks.
> > > 
> > > Hi Marek
> > > 
> > > I tested two Ethernet adapters, one SSD NVMe and our custom endpoint
> > > without the problem.
> > > Can you please send me your dts file if possible?
> > > 
> > > Do you use the latest Altera pcie driver in v4.4?
> > 
> > I'm using next from 20151223, crude patch is attached.
> 
> Hi Marek
> 
> Your dts looks fine, same as mine; except the 'ranges' parameter. Not
> sure why it is not working on your side.
> 
> I may try again with the linux-next later.

Looking forward to your observations ;-)

btw the other difference is location of the Cra port, in my case it's at 
0xff220000 , which matches the altera reference design. The example code
uses 0xff240000 for whatever reason.

Best regards,
Marek Vasut
