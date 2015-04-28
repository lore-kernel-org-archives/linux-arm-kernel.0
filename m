From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 28 Apr 2015 08:45:24 +0200
Subject: [PATCH] RFC: let gpiod_get_optional et all return NULL when
 GPIOLIB is not enabled
In-Reply-To: <CAAVeFuKMiHhT8o1PCETNTys8EATcVdy7xfy+P+o_2r6BwAXEgw@mail.gmail.com>
References: <1423731809-4800-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdb6KcZx3WfTqUKemhQ0_OsqxBGQb_P5cXXZvgc3riakdA@mail.gmail.com>
 <20150306085957.GC10717@pengutronix.de>
 <CACRpkdYq70V8SG4XOPBCGWs__J4ehknZSucpO5OdXpMDj8GPKA@mail.gmail.com>
 <CAAVeFu+0bWSAUSaDGTUmPyj9JxEJn4yxF_hzab4CHp8YV1MuoA@mail.gmail.com>
 <20150427152153.GN19431@pengutronix.de>
 <CAAVeFuKMiHhT8o1PCETNTys8EATcVdy7xfy+P+o_2r6BwAXEgw@mail.gmail.com>
Message-ID: <20150428064524.GV19431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Apr 28, 2015 at 12:31:37PM +0900, Alexandre Courbot wrote:
> On Tue, Apr 28, 2015 at 12:21 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Apr 09, 2015 at 11:20:55AM +0900, Alexandre Courbot wrote:
> >> Having GPIO disabled means there is no GPIO support, including the
> >> ability to look for GPIOs. -ENOSYS is a well-documented error-code
> >> which meaning also applies to the gpio_*_optional functions (we don't
> >> have support for the operation you requested). If a driver or
> >> architecture really, really needs GPIO support they can require or
> >> depend on CONFIG_GPIOLIB, and the problem goes away. If they can work
> >> with and without gpiolib, then they should check for -ENOSYS when they
> >> request GPIOs and behave accordingly.
> > What whould be the right behaviour in your eyes? I hope it's not
> >
> >         if (ret != -ENOSYS)
> >                 return ret;
> >
> >         /* continue and ignore error */
> 
> If a consumer absolutely needs a GPIO (most of the drivers out there I
> believe), then -ENOSYS can be handled like any other error. If it
> doesn't, and the driver is fine without GPIO support as well (meaning
> that it can somehow work even if a GPIO is declared, but GPIO support
> is not compiled in), then it will need to explicitly handle that
> particular error. That case should be rare though - most drivers will
> want to propagate -ENOSYS.
Ack.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
