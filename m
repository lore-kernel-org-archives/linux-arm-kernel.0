From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Apr 2011 09:27:59 +0100
Subject: [PATCH] V4L: mx3_camera: select VIDEOBUF2_DMA_CONTIG instead
	of VIDEOBUF_DMA_CONTIG
In-Reply-To: <20110418082049.GJ3811@pengutronix.de>
References: <1302166243-650-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110418080637.GA31131@pengutronix.de>
	<Pine.LNX.4.64.1104181013250.27247@axis700.grange>
	<20110418082049.GJ3811@pengutronix.de>
Message-ID: <20110418082759.GA25671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 10:20:49AM +0200, Robert Schwebel wrote:
> Uwe,
> 
> On Mon, Apr 18, 2011 at 10:14:56AM +0200, Guennadi Liakhovetski wrote:
> > It's been pushed upstream almost 2 weeks ago:
> >
> > http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/31352
> 
> As our autobuilder does still trigger, I assume that the configs have to
> be refreshed and it may be an issue on our side. Can you take care of
> that?

Just take a look at what's in mainline:

config VIDEO_MX3
        tristate "i.MX3x Camera Sensor Interface driver"
        depends on VIDEO_DEV && MX3_IPU && SOC_CAMERA
        select VIDEOBUF_DMA_CONTIG
        select MX3_VIDEO
        ---help---
          This is a v4l2 driver for the i.MX3x Camera Sensor Interface

and you'll see that it hasn't made it there yet.  If I search for
'linuxtv.org' in the history post 2.6.39-rc2, there's no sign of it.
