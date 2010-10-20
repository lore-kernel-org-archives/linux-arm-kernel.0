From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Oct 2010 15:09:03 +0200
Subject: [PATCH] ARM: imx: change mx51.h into mx5x.h
In-Reply-To: <20101020113550.GL2562@matterhorn.lan>
References: <1287525423-22329-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101020090122.GH28166@pengutronix.de>
	<20101020113550.GL2562@matterhorn.lan>
Message-ID: <20101020130903.GA19834@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Amit,

On Wed, Oct 20, 2010 at 02:35:50PM +0300, Amit Kucheria wrote:
> On 10 Oct 20, Uwe Kleine-K?nig wrote:
> > Hello Dinh,
> > 
> > On Tue, Oct 19, 2010 at 04:57:03PM -0500, Dinh.Nguyen at freescale.com wrote:
> > > From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> > > 
> > > In preparation for submitting i.MX53 support, change mx51.h to
> > > mx5x.h so that mx5x.h can contain MX53 information as well.
> > Last time I found time to clean up the imx ports I worked hard that e.g.
> > mx27 machines only used MX27_ prefixed symbols, not the MX2x_ ones.  (I
> > don't remember off-hand if I was done, so there might be a few users
> > left.)
> > 
> > I'd prefer to just add an mx53.h instead.
> 
> Perhaps this is a good time to ask the question - Why?
> 
> mx53.h will duplicate (almost) everything in mx51.h. And any fixes made to
> mx51.h won't make it to mx53.h
Yep, that's the pro side of having a single header file for both mx51
and mx53.  On the negative side we have:

 - When changing mx5x.h you always have to check (now) two reference
   manuals, later maybe more.
 - When Freescale decides to create a (say) mx56 that is totally
   different, you can be happy not to have constants starting with MX5X.
   (This happened to the MX2X constants when Freescale created mx25, not
   to mention mx23 and mx28.)

I admit that *now* it would be easier to just rename mx51.h to mx5x.h,
but for the long run keeping mx51.h is better, I'm sure.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
