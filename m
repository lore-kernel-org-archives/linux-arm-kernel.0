From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 7 Jan 2015 07:38:49 -0500
Subject: [PATCH] irqchip: atmel-aic-common: prevent clobbering of
 priority when changing IRQ type
In-Reply-To: <54ACF68B.2040000@atmel.com>
References: <1420598843-8409-1-git-send-email-gavinli@thegavinli.com>
 <20150107030922.GF24989@titan.lakedaemon.net>
 <54ACF68B.2040000@atmel.com>
Message-ID: <20150107123849.GH24989@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 10:04:11AM +0100, Nicolas Ferre wrote:
> Le 07/01/2015 04:09, Jason Cooper a ?crit :
> > atmel maintainers,
> > 
> > On Tue, Jan 06, 2015 at 06:47:23PM -0800, gavinli at thegavinli.com wrote:
> >> From: Gavin Li <git@thegavinli.com>
> >>
> >> This patch makes the bitmask for AIC_SRCTYPE consistent
> >> with that of its valid values, and prevents the priority
> >> field at bits 2:0 from being clobbered by an incorrect
> >> AND with the AIC_SRCTYPE mask.
> >>
> >> Signed-off-by: Gavin Li <gavinli@thegavinli.com>
> >> ---
> >>  drivers/irqchip/irq-atmel-aic-common.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Please give an Acked-by if this looks good to you.  I'd like to get it
> > pushed fairly soon.
> 
> Hi Jason,
> 
> After a private message with Boris, here is our:
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> It is indeed a pretty important fix.
> 
> (I added the linux-arm-kernel mailing-list for the record).

:)  oops.  I completely missed that it was originally (and this version)
off-list.  Gavin, in the future, please include the mailinglist when
sending.

> Moreover, can you please add a stable tag like:
> Cc: <stable@vger.kernel.org> # 3.17+

Will do.

thx,

Jason.
