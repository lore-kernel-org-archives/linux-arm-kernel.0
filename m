From: will.deacon@arm.com (Will Deacon)
Date: Sat, 28 Jul 2012 15:38:50 +0100
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <50130F36.4090902@gmail.com>
References: <50049285.1060100@gmail.com>
 <50130F36.4090902@gmail.com>
Message-ID: <20120728143850.GA11713@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Jul 27, 2012 at 10:59:18PM +0100, Rob Herring wrote:
> Please pull updated io.h cleanup for PCI branch. I rebased this as the
> changes shifted things around a bit. This has the following changes:
> 
> - Incorporated fixes from you and Stephen
> - Add early i/o mapping pci_map_io_early and enable on footbridge and
> integrator for VGA console

Unfortunately, I still experience the same hang on integrator with this
revised patch series. Given the turnaround time for testing this, I don't
think this should block the series, but I would like to get to the bottom of
it if possible.

I tried annotating the PCI code (including fault handlers) and the VGA
console code but I couldn't find the culprit. I suppose the next step is
JTAG, but that requires steal^Wborrowing some hardware from work.

Will
