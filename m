From: greg@kroah.com (Greg KH)
Date: Mon, 26 Oct 2009 11:52:58 -0700
Subject: [WARNING] pxamci: 'pxa2xx-mci.0' does not have a release()
	function.
In-Reply-To: <20091026184815.GA16735@sirena.org.uk>
References: <20091023003631.1331a60a.ospite@studenti.unina.it>
	<20091022225758.GA9106@n2100.arm.linux.org.uk>
	<20091023115028.59ed7f74.ospite@studenti.unina.it>
	<20091023101806.GB19437@n2100.arm.linux.org.uk>
	<20091026165852.GC18218@kroah.com>
	<20091026184815.GA16735@sirena.org.uk>
Message-ID: <20091026185258.GA27560@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2009 at 06:48:15PM +0000, Mark Brown wrote:
> On Mon, Oct 26, 2009 at 09:58:52AM -0700, Greg KH wrote:
> > On Fri, Oct 23, 2009 at 11:18:06AM +0100, Russell King - ARM Linux wrote:
> > > On Fri, Oct 23, 2009 at 11:50:28AM +0200, Antonio Ospite wrote:
> 
> > > > A little more background: we need pxamci to be a child of SPI because
> > > > our PMIC is connected via SPI, and a PMIC regulator is used for mmc
> > > > powering; enforcing this hierarchy is needed to make pxamci suspend and
> > > > resume properly.
> 
> > > I don't think this is the right solution - and I don't know what the
> > > right solution would be given that the interfaces I suspect you need
> > > aren't public.
> 
> > Um, why not ask the SPI maintainer?  I don't know what the SPI code is
> > doing, sorry.
> 
> It's not specific to SPI - the problem is the need to express ordering
> constraints in suspend/resume that go beyond what the device tree gives.
> 
> I believe that the pm_link stuff in -next is what's needed here?  I was
> planning to look at this within the regulator API before the next merge
> window so that I can hopefully have something ready for -next after that
> (or possibly even get it in in the same merge window if the cross tree
> issues aren't too painful).

Yes, talk to Rafael about that stuff, he's responsible for it :)

thanks,

greg k-h
