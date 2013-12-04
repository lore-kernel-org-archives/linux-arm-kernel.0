From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 11:25:40 -0800
Subject: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
In-Reply-To: <20131204191606.GL29721@pengutronix.de>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
 <5283A8C7.30904@atmel.com> <529C4936.5060304@atmel.com>
 <20131204102353.GI29721@pengutronix.de>
 <20131204170911.GC14859@kroah.com>
 <20131204191606.GL29721@pengutronix.de>
Message-ID: <20131204192540.GC11841@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 08:16:06PM +0100, Uwe Kleine-K?nig wrote:
> Hello Greg,
> 
> On Wed, Dec 04, 2013 at 09:09:11AM -0800, Greg Kroah-Hartman wrote:
> > On Wed, Dec 04, 2013 at 11:23:53AM +0100, Uwe Kleine-K?nig wrote:
> > > Hello Greg, hi Nicolas,
> > > 
> > > On Mon, Dec 02, 2013 at 09:47:50AM +0100, Nicolas Ferre wrote:
> > > > On 13/11/2013 17:28, Nicolas Ferre :
> > > > >On 07/11/2013 10:25, Linus Walleij :
> > > > >>This passes the errata fix using a GPIO to control the RTS pin
> > > > >>on one of the AT91 chips to use gpiolib instead of the
> > > > >>AT91-specific interfaces. Also remove the reliance on
> > > > >>compile-time #defines and the cpu_* check and rely on the
> > > > >>platform passing down the proper GPIO pin through platform
> > > > >>data.
> > > > >>
> > > > >>This is a prerequisite for getting rid of the local GPIO
> > > > >>implementation in the AT91 platform and move toward
> > > > >>multiplatform.
> > > > >>
> > > > >>The patch also adds device tree support for getting the
> > > > >>RTS GPIO pin from the device tree on DT boot paths.
> > > > >>
> > > > >>Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > >>Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > > >>Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > > >
> > > > >Hi Greg,
> > > > >
> > > > >You acknowledged a previous version of this patch which was taking a
> > > > >different approach with the subject:
> > > > >"[PATCH 1/4] ARM/serial: at91: move machine quirk into machine"
> > > > >
> > > > >In order to integrate the series build by Linus in our AT91/arm-soc
> > > > >flow, would you mind reviewing this v4 patch and eventually giving your
> > > > >blessing ;-)
> > > > >If it is okay on your side, I'll integrate it in a pull-request to
> > > > >arm-soc for 3.14.
> > > > 
> > > > Greg, ping?
> > > I'm depending on that patch for a series that gets rid of ARM's
> > > <mach/timex.h>. So I'm interested to either get a stable commit to
> > > base on or alternatively to get the blessing from both of you to take it
> > > (also via arm-soc) as part of my series.
> > > 
> > > A preview of my series is available at
> > > 
> > > 	git://git.pengutronix.de/git/ukl/linux.git deprecatemachtimexh
> > 
> > No objection from me to take it through your tree.
> gregkh: Thanks. I'll interpret this as Acked-by: you if Nicolas also
> agrees that I take it.

I gave it on a previous email in this thread, but here it is again for
you:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
