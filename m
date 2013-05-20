From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 14:02:54 -0400
Subject: [PATCHv10 5/9] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
In-Reply-To: <20130519204703.GP11137@titan.lakedaemon.net>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368719725-21265-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130519204703.GP11137@titan.lakedaemon.net>
Message-ID: <20130520180254.GD31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 04:47:03PM -0400, Jason Cooper wrote:
> On Thu, May 16, 2013 at 05:55:20PM +0200, Thomas Petazzoni wrote:
> > The Armada 370 has two gatable clocks for each PCIe interface, and we
> > want both of them to be enabled. We therefore make one of the two
> > clocks a child of the other, as we did for the sataX and sataXlnk
> > clocks on Armada XP.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > ---
> >  drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Patches 5 - 8 applied to mvebu/pcie, with a dep on Sebastian's clock
> rework and mvebu/of_pci.  Thanks for the head's up on the clk conflict.
> My resolution should match yours.  Please let me know if it doesn't.

As stated in the clk thread, I'm going to re-order this so pcie doesn't
depend on the clk series.

thx,

Jason.
