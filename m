From: marex@denx.de (Marek Vasut)
Date: Mon, 4 Jan 2016 00:36:55 +0100
Subject: [PATCH] doc: PCI: altera: Fix the 'ranges' property in example
In-Reply-To: <1451863780.3051.12.camel@ubuntu>
References: <1450950330-28393-1-git-send-email-marex@denx.de>
 <201512311004.35234.marex@denx.de> <1451863780.3051.12.camel@ubuntu>
Message-ID: <201601040036.55446.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 04, 2016 at 12:29:40 AM, Ley Foon Tan wrote:
> On Thu, 2015-12-31 at 10:04 +0100, Marek Vasut wrote:
> > On Thursday, December 31, 2015 at 04:09:01 AM, Ley Foon Tan wrote:
> > > On Tue, 2015-12-29 at 14:33 +0100, Marek Vasut wrote:
> > > > On Tuesday, December 29, 2015 at 08:48:33 AM, Ley Foon Tan wrote:
> > > > > On Mon, 2015-12-28 at 09:26 +0100, Marek Vasut wrote:
> > > > > > On Monday, December 28, 2015 at 08:42:00 AM, Ley Foon Tan wrote:
> > > > > > > On Mon, Dec 28, 2015 at 3:34 PM, Marek Vasut <marex@denx.de> 
wrote:
> > > > > > > > On Monday, December 28, 2015 at 07:56:15 AM, Ley Foon Tan wrote:
> > > > > > > >> On Thu, 2015-12-24 at 10:45 +0100, Marek Vasut wrote:
> > > > > > > >> > The example does not work on real hardware with the PCIe
> > > > > > > >> > HIP [1]. The problem is with incorrect "ranges" property
> > > > > > > >> > in the example, so one cannot just copy-paste the example
> > > > > > > >> > into his DT and expect this to work. This patches aligns
> > > > > > > >> > the "ranges" in the example with the reference FPGA
> > > > > > > >> > design.
> > > > > > > >> 
> > > > > > > >> Hi Marek
> > > > > > > > 
> > > > > > > > Hi Ley,
> > > > > > > > 
> > > > > > > >> The original "ranges" is working for me. What error did you
> > > > > > > >> encounter?
> > > > > > > > 
> > > > > > > > Every time a driver accessed the Txs range, the system got
> > > > > > > > stuck hard. The Cra access always worked fine though, so the
> > > > > > > > PCIe devices were always detected.
> > > > > > > > 
> > > > > > > > I checked with signaltap and my impression is that the wrong
> > > > > > > > address propagated into the request passed to the Txs port of
> > > > > > > > the HardIP block, unless I change the range configuration.
> > > > > > > > 
> > > > > > > > Note that I tested Intel Centrino 6235 WiFi card and Atheros
> > > > > > > > AR5006 WiFi card. The intel in particular uses both the Txs
> > > > > > > > and even MSI , so to use the intel, the whole PCIe block has
> > > > > > > > to work properly ; with this change, it does and I can use
> > > > > > > > the intel card just fine.
> > > > > > > > 
> > > > > > > >> Thanks.
> > > > > > > 
> > > > > > > Hi Marek
> > > > > > > 
> > > > > > > I tested two Ethernet adapters, one SSD NVMe and our custom
> > > > > > > endpoint without the problem.
> > > > > > > Can you please send me your dts file if possible?
> > > > > > > 
> > > > > > > Do you use the latest Altera pcie driver in v4.4?
> > > > > > 
> > > > > > I'm using next from 20151223, crude patch is attached.
> > > > > 
> > > > > Hi Marek
> > > > > 
> > > > > Your dts looks fine, same as mine; except the 'ranges' parameter.
> > > > > Not sure why it is not working on your side.
> > > > > 
> > > > > I may try again with the linux-next later.
> > > > 
> > > > Looking forward to your observations ;-)
> > > 
> > > Tested with 20151223 linux-next, it is working with original dts.
> > 
> > Well, do you have a good explanation why the system works with this
> > change and doesn't work without it on my design ? I'd really love to
> > understand this.
> 
> Do you modify the driver to setup the translation table?

No, I didn't change the driver. What do you refer to please ?

Best regards,
