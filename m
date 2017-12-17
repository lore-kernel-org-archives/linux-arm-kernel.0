From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 17 Dec 2017 19:01:08 +0100
Subject: [PATCH] bus: simple-pm-bus: convert bool SIMPLE_PM_BUS to tristate
In-Reply-To: <20171201070232.v4uilgo5cydaoyqa@verge.net.au>
References: <1512043020-23452-1-git-send-email-geert+renesas@glider.be>
 <20171201070232.v4uilgo5cydaoyqa@verge.net.au>
Message-ID: <3708548.hFOf0HkmBe@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 1, 2017 8:02:33 AM CET Simon Horman wrote:
> On Thu, Nov 30, 2017 at 12:57:00PM +0100, Geert Uytterhoeven wrote:
> > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> > The Kconfig currently controlling compilation of this code is:
> > 
> > config SIMPLE_PM_BUS
> >         bool "Simple Power-Managed Bus Driver"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > In removing the orphaned modular support in a previous patch set,
> > Geert indicated he'd rather see this code converted to tristate.
> > 
> > I normally don't do that because it extends functionality that I
> > can't easily run time test or even know if the use case makes sense,
> > but since in this case the author has nominated it as such, we do
> > the conversion here.
> > 
> > Note that doesn't change the lack of run time testing ; this change
> > is only tested for sucessful compile and modpost.
> > 
> > [geert: Ethernet is probed successfully on sh73a0/kzm9g after
> >         insmodding simple-pm-bus.ko]
> > 
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Applied, thanks!
