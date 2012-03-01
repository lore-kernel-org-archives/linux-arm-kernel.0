From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Mar 2012 10:58:48 +0100
Subject: [PATCH] regulator mc13783: bail out without platform data
In-Reply-To: <20120229231951.GB8295@opensource.wolfsonmicro.com>
References: <1330502500-30567-1-git-send-email-s.hauer@pengutronix.de>
 <20120229231951.GB8295@opensource.wolfsonmicro.com>
Message-ID: <20120301095848.GZ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 11:19:51PM +0000, Mark Brown wrote:
> On Wed, Feb 29, 2012 at 09:01:40AM +0100, Sascha Hauer wrote:
> > the platform data pointer is used without checking it. Bail out
> > in the driver instead of crashing the kernel.
> 
> Applied, thanks.  Ideally the platform data would just specify the
> constraints and the driver would still be able to register the
> regulators even without constriants being provided to allow diagnostics.

Indeed. I can follow up on this when I find the time. For now I'm happy
with the kernel not crashing.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
