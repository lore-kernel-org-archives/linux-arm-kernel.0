From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 11 Sep 2012 08:56:04 +0200
Subject: [PATCH 13/25] macintosh/mediabay: add a const qualifier
In-Reply-To: <1346837023.2257.57.camel@pasglop>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
 <1346812817.2257.23.camel@pasglop>
 <20120905080249.GI28643@pengutronix.de>
 <1346837023.2257.57.camel@pasglop>
Message-ID: <20120911065604.GE28643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 07:23:43PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-09-05 at 10:02 +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Wed, Sep 05, 2012 at 12:40:17PM +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2012-07-23 at 11:13 +0200, Uwe Kleine-K?nig wrote:
> > > > This prepares *of_device_id.data becoming const. Without this change
> > > > the following warning would occur:
> > > > 
> > > > 	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
> > > > 	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> > > > 
> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > 
> > > Ack all of these assuming you test built (I didn't).
> > "all" means the two mediabay patches? And yes, they are all built
> > tested.
> 
> Yeah, anything powerpc you had in your series, but the two mediabay ones
> are what I spotted when digging through stuff today :-)
I added that to

 serial/mpc52xx_uart: add a const qualifier
 gpio/mpc8xxx: add a const qualifier
 i2c/mpc: add a const qualifier
 macintosh/mediabay: add a const qualifier
 powerpc/83xx: add a const qualifier
 powerpc/fsl_msi: add a const qualifier
 powerpc/celleb_pci: add a const qualifier
 watchdog/mpc8xxx: add a const qualifier
 powerpc/fsl_msi: drop unneeded cast to non-const pointer
 i2c/mpc: make data used as *of_device_id.data const
 macintosh/mediabay: make data used as *of_device_id.data const
 can: mpc5xxx_can: make data used as *of_device_id.data const

in the hope I didn't interpret "anything powerpc" too wide. Please tell
me if I did.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
