From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 28 Dec 2012 19:45:26 +0800
Subject: [REGRESSION][3.8.-rc1][ INFO: possible circular locking
 dependency detected ]
In-Reply-To: <1356613404.16896.4.camel@thor.lan>
References: <201212221628.26640.maciej.rutecki@gmail.com>
 <20121226023435.GE25478@S2101-09.ap.freescale.net>
 <20121227083618.GA9775@S2101-09.ap.freescale.net>
 <1356613404.16896.4.camel@thor.lan>
Message-ID: <20121228114525.GD19447@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 08:03:24AM -0500, Peter Hurley wrote:
> On Thu, 2012-12-27 at 16:36 +0800, Shawn Guo wrote:
> > On Wed, Dec 26, 2012 at 10:34:39AM +0800, Shawn Guo wrote:
> > > It seems that I'm running into the same locking issue.  My setup is:
> > > 
> > > - i.MX28 (ARM)
> > > - v3.8-rc1
> > > - mxs_defconfig
> >   - The warning is seen when LCD is blanking
> > > 
> > 
> > The warning disappears after reverting patch daee779 (console: implement
> > lockdep support for console_lock).  Is it suggesting that the mxs
> > frame buffer driver (drivers/video/mxsfb.c) is doing something bad?
> > 
> > Shawn
> > 
> > > 
> > > [  602.229899] ======================================================
> > > [  602.229905] [ INFO: possible circular locking dependency detected ]
> > > [  602.229926] 3.8.0-rc1-00003-gde4ae7f #767 Not tainted
> > > [  602.229933] -------------------------------------------------------
> > > [  602.229951] kworker/0:1/21 is trying to acquire lock:
> > > [  602.230037]  ((fb_notifier_list).rwsem){.+.+.+}, at: [<c0041f34>] __blocking_notifier_call_chain+0x2c/0x60
> 
> You want this patch https://patchwork.kernel.org/patch/1757061/
> 
Thanks for the pointer, Peter.  It does fix the problem for me.

Shawn
