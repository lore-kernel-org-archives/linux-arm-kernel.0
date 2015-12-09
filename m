From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 9 Dec 2015 09:09:35 -0600
Subject: [PATCH v3] PCI: imx6: Fix reset-gpio to work with active low GPIO
In-Reply-To: <20151204210234.GH20125@localhost>
References: <1448620464.3689.94.camel@pengutronix.de>
 <1448621794-19916-1-git-send-email-ynezz@true.cz>
 <20151204205906.GG20125@localhost>
 <20151204210234.GH20125@localhost>
Message-ID: <20151209150935.GC31930@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Jingoo's response didn't make it to the list because it contained
HTML, but I incorporated it below manually]

On Tue, Dec 8, 2015 at 11:28 PM, Han Jingoo wrote:
> On Fri, Dec 04, 2015 at 03:02:34PM -0600, Bjorn Helgaas wrote:
> > [+cc Jingoo]
> > 
> > On Fri, Dec 04, 2015 at 02:59:06PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Nov 27, 2015 at 11:56:34AM +0100, Petr ?tetiar wrote:
> > > > It's currently not possible to use reset-gpio on board where the GPIO is
> > > > active low as the code incorrectly assumes, that reset-gpio will be
> > > > always active high.
> > > > 
> > > > In my case the broken behavior was observed on Toradex Apalis SoM with
> > > > Ixora base board.
> > > > 
> > > > Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> > > 
> > > Applied as follows with Lucas' reviewed-by to pci/host-imx6 for v4.5,
> > > thanks!
> > 
> > Jingoo, I noticed pci-exynos.c also uses of_get_named_gpio().  Do you
> > care about this issue, too, or are you content to ignore the GPIO
> > flags for your "reset-gpio"?
>
> Sorry, I don't care about it.
> Also, there is no issue with Exynos platform.

OK, thanks for checking!

Bjorn
