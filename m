From: atull@opensource.altera.com (atull)
Date: Wed, 15 Oct 2014 15:17:51 -0500
Subject: [PATCH v3 2/2] socfpga: support suspend to ram
In-Reply-To: <20141015075001.GB10720@amd>
References: <1413315219-28885-1-git-send-email-atull@opensource.altera.com>
 <1413315219-28885-3-git-send-email-atull@opensource.altera.com>
 <20141015075001.GB10720@amd>
Message-ID: <alpine.DEB.2.02.1410151517350.28205@atx-linux-37>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Oct 2014, Pavel Machek wrote:

> On Tue 2014-10-14 14:33:39, atull at opensource.altera.com wrote:
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Add code that requests that the sdr controller go into
> > self-refresh mode.  This code is run from ocram.
> > 
> > This patch assumes that u-boot has already configured sdr:
> >   sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
> >   sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
> >   sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
> > 
> > How to suspend to ram:
> >  $ echo enabled > \
> > /sys/devices/soc/ffc02000.serial0/tty/ttyS0/power/wakeup
> > 
> >  $ echo -n mem > /sys/power/state
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> 
> Acked-by: Pavel Machek <pavel@denx.de>
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 

Thanks!

Alan
