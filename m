From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 21 Oct 2009 22:51:56 +0200
Subject: MXC MMC driver and SDIO peripherals
In-Reply-To: <1256156119.8469.40.camel@localhost.localdomain>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
	<1256156119.8469.40.camel@localhost.localdomain>
Message-ID: <20091021205156.GO14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Wed, Oct 21, 2009 at 01:15:19PM -0700, Dan Williams wrote:
> On Wed, 2009-10-21 at 21:20 +0200, Daniel Mack wrote:
> > Hi,
> > 
> > we're having trouble getting SDIO connected harware to fly on MX31 based
> > designs. In particular, a SD8686 chip supported by the libertas_sdio
> > driver will hang forever when built without CONFIG_MMC_DEBUG=y. With
> > that option selected, however, the behaviour is a little different, and
> > I can at least see the following messages on a recent 2.6.32-rc5 based
> > MX31 tree.
> > 
> > Is there any common pitfall for such setups? I did more or less the same
> > thing on PXAs (same WLAN chip, same kind of interface, same firmware),
> > and haven't seen any such effects, so I suspect the MXC specific parts
> > to be the reason for that. Any ideas?
> 
> Any idea what quirks your SDHC is using if any?  Does it require PIO or
> can it do DMA? 

In mainline kernels, DMA is limited to the MX2 SoC family. The MX3 that
I'm using is excluded from that feature, but I'mm not aware of the
reason for that.

> Does it have any transfer restrictions on block size or
> bit-width? 

I didn't really debug it yet, but from what I see in the sources, the
maximum block size is 2048. The hardware is connected via the 4-wire
interface (+clk, +cmd). The system I tried that on has a MMC slot where
I can plug in either the WLAN eval kit or a memory card, and the latter
works just fine, which tells me that at least the pin config and the
hardware can't be entirely wrong.

> What is the debug output of the MMC stack when loading the
> module for your SDHC?

Exactly one line ;)

[    1.340000] i.MX SDHC driver


Daniel
