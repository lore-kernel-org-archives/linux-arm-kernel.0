From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Oct 2013 14:04:38 -0400
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.13
In-Reply-To: <20131007170206.GE15413@quad.lixom.net>
References: <20130930153643.GF31178@titan.lakedaemon.net>
 <20131007170206.GE15413@quad.lixom.net>
Message-ID: <20131007180438.GB5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Oct 07, 2013 at 10:02:06AM -0700, Olof Johansson wrote:
> Hi Jason,
> 
> On Mon, Sep 30, 2013 at 11:36:43AM -0400, Jason Cooper wrote:
> > Guys,
> > 
> > Here are all of the driver changes that didn't make it during the last
> > merge window.  They've been in -next since v3.12-rc1, without
> > merge-conflicts or build issues.
> 
> It looks like the PCI pieces here are all independent now and can go through
> Bjorn's tree instead of arm-soc. Or do you anticipate having something
> dependent on this later on such that we should take it?

I chose to keep them on the same path as last window because of the
dependency between the irqchip changes:

  627dfcc irqchip: armada-370-xp: properly request resources
  31f614e irqchip: armada-370-xp: implement MSI support

which the pci/msi changes depend on.

> For 3.12 it was easier to take through arm-soc since this built on top of the
> other PCI/MSI work we were queueing.

As well as the irqchip changes...

> If you want us to take it, see if you can shake an ack out of Bjorn, mostly to
> make sure he's aware that there's PCI code going through our tree.

Here's a link to where Bjorn agreed to the strategy for this merge
window:

http://lkml.org/lkml/2013/9/27/474

hth,

Jason.
