From: greg@kroah.com (Greg KH)
Date: Sat, 3 Aug 2013 06:32:47 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802160932.GG5292@mudshark.cambridge.arm.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802115334.GN2465@mudshark.cambridge.arm.com>
 <20130802142010.GC7533@kroah.com>
 <20130802160932.GG5292@mudshark.cambridge.arm.com>
Message-ID: <20130802223247.GC28831@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 05:09:32PM +0100, Will Deacon wrote:
> On Fri, Aug 02, 2013 at 03:20:10PM +0100, Greg KH wrote:
> > On Fri, Aug 02, 2013 at 12:53:34PM +0100, Will Deacon wrote:
> > > We can change the mindset by yelling, but if you're writing a new
> > > driver for a peripheral on an ARM SoC, platform_bus is mighty tempting
> > > because you get a bunch of device-tree parsing code for free (see
> > > drivers/of/platform.c).
> > 
> > I know :(
> > 
> > So, who do I "yell at", and what do I do to make things easier for you
> > from the driver-core perspective?
> 
> I would anticipate most of these drivers going through the arm-soc tree, so
> Olof and Kevin would be doing the yelling. You could join in the chorus too!
> 
> We basically need reviewers to adopt the position that a new bus should be
> considered and dismissed before using the platform_bus, then you can yell
> transitively through them.

I don't scale if I'm forced to review every driver to ensure that they
shouldn't be using platform device and should be creating their own bus
type.  You can do that, along with the other ARM developers reviewing
these new subsystems and code being added.

thanks,

greg k-h
