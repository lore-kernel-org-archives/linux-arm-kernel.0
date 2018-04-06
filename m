From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 6 Apr 2018 08:33:56 -0500
Subject: [PATCH v4 1/6] PCI: aardvark: Introduce an
 advk_pcie_valid_device() helper
In-Reply-To: <20180406112128.6b904f39@windsurf>
References: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
 <20180329083946.25970-2-thomas.petazzoni@bootlin.com>
 <20180404112843.GA24669@red-moon>
 <20180406112128.6b904f39@windsurf>
Message-ID: <20180406133356.GA163363@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 11:21:28AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Wed, 4 Apr 2018 12:28:43 +0100, Lorenzo Pieralisi wrote:
> > On Thu, Mar 29, 2018 at 10:39:41AM +0200, Thomas Petazzoni wrote:
> > > In other to mimic other PCIe host controller drivers, introduce an
> > > advk_pcie_valid_device() helper, used in the configuration read/write
> > > functions.
> > > 
> > > This patch by itself is not a fix, but it is required for a follow-up
> > > patch that is a fix, hence the Fixes tag and the Cc to stable.  
> > 
> > Should not we just reshuffle patch 1 and 2 instead of sending this
> > patch to stable ? I appreciate the merge window is open and timing is
> > quite tight, it is just to avoid sending churn to stable kernels
> > for not much.
> 
> I can certainly do that, but it's actually Bjorn who asked in the first
> place to introduce the advk_pcie_valid_device() helper.

I did suggest [1] adding advk_pcie_valid_device() to match other
drivers, but I don't care about the order of these patches.  If it
makes more sense to put the fix first for easier backporting to
stable, that's fine with me.

[1] https://lkml.kernel.org/r/20180110011136.GB157182 at bhelgaas-glaptop.roam.corp.google.com
