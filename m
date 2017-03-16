From: phdm@macq.eu (Philippe De Muyter)
Date: Thu, 16 Mar 2017 11:19:06 +0100
Subject: media / v4l2-mc: wishlist for complex cameras (was Re: [PATCH
 v4 14/36] [media] v4l2-mc: add a function to inherit controls from
 a pipeline)
In-Reply-To: <1489658516.2303.11.camel@pengutronix.de>
References: <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170314072143.498cde9b@vento.lan> <20170314223254.GA7141@amd>
 <20170314215420.6fc63c67@vento.lan> <20170315105049.GA12099@frolo.macqel>
 <1489604109.4593.4.camel@ndufresne.ca>
 <1489656360.2303.2.camel@pengutronix.de> <20170316094729.GA5595@frolo.macqel>
 <1489658516.2303.11.camel@pengutronix.de>
Message-ID: <20170316101906.GA13126@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 11:01:56AM +0100, Philipp Zabel wrote:
> On Thu, 2017-03-16 at 10:47 +0100, Philippe De Muyter wrote:
> > On Thu, Mar 16, 2017 at 10:26:00AM +0100, Philipp Zabel wrote:
> > > On Wed, 2017-03-15 at 14:55 -0400, Nicolas Dufresne wrote:
> > > > Le mercredi 15 mars 2017 ? 11:50 +0100, Philippe De Muyter a ?crit :
> > > > > > I would say: camorama, xawtv3, zbar, google talk, skype. If it runs
> > > > > > with those, it will likely run with any other application.
> > > > > > 
> > > > > 
> > > > > I would like to add the 'v4l2src' plugin of gstreamer, and on the
> > > > > imx6 its
> > > > 
> > > > While it would be nice if somehow you would get v4l2src to work (in
> > > > some legacy/emulation mode through libv4l2),
> > > 
> > > v4l2src works just fine, provided the pipeline is configured manually in
> > > advance via media-ctl.
> > 
> > Including choosing the framerate ?  Sorry, I have no time these days
> > to test it myself.
> 
> No, the framerate is set with media-ctl on the CSI output pad. To really
> choose the framerate, the element would indeed need a deeper
> understanding of the pipeline, as the resulting framerate depends on at
> least the source v4l2_subdevice (sensor) framerate and the CSI frame
> skipping.

Count me in than as a supporter of Steve's "v4l2-mc: add a function to
inherit controls from a pipeline" patch

> > of the image buffers for further processing by other (not necessarily next
> > in gstreamer pipeline, or for all frames) hardware-accelerated plugins likes
> > the h.264 video encoder.  As I am stuck with fsl/nxp kernel and driver on that
> > matter, I don't know how the interfaces have evolved in current linux kernels.
> 
> The physical address of the image buffers is hidden from userspace by
> dma-buf objects, but those can be passed around to the next driver
> without copying the image data.

OK

thanks

Philippe
