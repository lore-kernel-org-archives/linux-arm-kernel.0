From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Feb 2011 09:39:28 +0100
Subject: [PATCH 16/17] mc13xxx: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110216090036.6fffed34@debxo>
References: <20110211181921.3d561568@queued.net>
	<20110216094154.GV13279@pengutronix.de>
	<20110216090036.6fffed34@debxo>
Message-ID: <20110218083928.GU22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 09:00:36AM -0800, Andres Salomon wrote:
> On Wed, 16 Feb 2011 10:41:54 +0100
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > On Fri, Feb 11, 2011 at 06:19:21PM -0800, Andres Salomon wrote:
> > > 
> > > The cell's platform_data is now accessed with a helper function;
> > > change clients to use that, and remove the now-unused data_size.
> > > 
> > > Note that mfd-core no longer makes a copy of platform_data, but the
> > why was this changed and where?  I'm not able to find your complete
> > series via gmane.
> 
> http://permalink.gmane.org/gmane.linux.kernel/1099164
I still don't get the motivation of your patch set.  For drivers that
don't need the mfd_cells you introduce another level of indirection.
And drivers that want to use mfd_cells as platform_data, they can
already now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
