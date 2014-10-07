From: atull@opensource.altera.com (atull)
Date: Tue, 7 Oct 2014 09:17:34 -0500
Subject: [PATCH v2 2/2] socfpga: support suspend to ram
In-Reply-To: <20141007111715.GB6904@amd>
References: <1412192304-1209-1-git-send-email-atull@opensource.altera.com>
 <1412192304-1209-3-git-send-email-atull@opensource.altera.com>
 <20141007111715.GB6904@amd>
Message-ID: <alpine.DEB.2.02.1410070916590.9610@atx-linux-37>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Oct 2014, Pavel Machek wrote:

> Hi!
> 
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
> > +static int __init socfpga_pm_init(void)
> > +{
> > +	if (socfpga_setup_ocram_self_refresh())
> > +		return -EFAULT;
> 
> It would be nice to propagate the error result here.

Hi Pavel,

Yes, good catch.

Thanks,
Alan

> 
> Best regards,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
