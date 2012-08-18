From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 18 Aug 2012 10:13:00 +0200
Subject: [PATCH] I2C: OMAP: xfer: fix runtime PM get/put balance on error
In-Reply-To: <87wr1b35qb.fsf@ti.com>
References: <1340761532-27231-1-git-send-email-khilman@ti.com>
 <87wr1b35qb.fsf@ti.com>
Message-ID: <20120818081300.GE24639@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 05:28:44PM -0700, Kevin Hilman wrote:
> Hi Wolfram,
> 
> Kevin Hilman <khilman@ti.com> writes:
> 
> > In omap_i2c_xfer(), ensure pm_runtime_put() is called, even on
> > failure.
> >
> > Without this, after a failed xfer, the runtime PM usecount will have
> > been incremented, but not decremented causing the usecount to never
> > reach zero after a failure.  This keeps the device always runtime PM
> > enabled which keeps the enclosing power domain active, and prevents
> > full-chip retention/off from happening during idle.
> >
> > Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> > This patch applies to current i2c-embedded/for-next branch
> 
> This one is needed for v3.6.  Can you queue this up as a fix for
> v3.6-rc?

Done, applied to -current, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120818/5491bc9d/attachment.sig>
