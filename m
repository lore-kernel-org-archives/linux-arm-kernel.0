From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 24 Aug 2012 19:38:08 +0200
Subject: [PATCH 4/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <806769921.2812305.1345819977325.JavaMail.root@advansee.com>
References: <1596192785.2810155.1345817566620.JavaMail.root@advansee.com>
 <806769921.2812305.1345819977325.JavaMail.root@advansee.com>
Message-ID: <20120824173808.GN31821@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beno?t,

On Fri, Aug 24, 2012 at 04:52:57PM +0200, Beno?t Th?baudeau wrote:
> What is the status of this series, and especially of this patch, as to
> its integration into upstream? At some point, you were talking about
> pushing it to staging, but since things don't seem to have evolved.

Things are making progress. The intention is to get the base patches
into staging; however, the holiday season made the progress a bit slow
recently.

> > The IPU has other units missing in this patch:
> >
> > - CMOS Sensor Interface (csi)
> > - Video Deinterlacer (vdi)
> > - Sensor Multi FIFO Controler (smfc)
> > - Image Converter (ic)
> > - Image Rotator (irt)
> >
> > So expect more files to come in this directory.
>
> Do you have a schedule for that? Are you waiting for more customer
> projects at Pengutronix to do that?

We don't have a fixed schedule; things make progress according to what
our projects make possible. The more customers we get behind this
effort, the more time we can spent on it.

- CSI is running on MX6 here
- Deinterlacer is WIP on MX53
- VPU was posted today, based on the Vista Silicon patches; we can do
  encoding and decoding, but not in all possible formats
- scaler works here
- We have a m2m plugin for GStreamer (which needs polishing as well, but
  works)

> That would be great to finally have full IPU/VPU/GPU support for i.MX5
> into upstream. As you already know, Linaro also have some video
> support for i.MX5 in this head:
> http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=shortlog;h=refs/heads/lt-3.2-imx5

That's quite an old tree... especially the port to 3.5 made a lot of
headache until all the oftree and clock issues were solved. However,
it's still good for reference.

> Is there a plan to merge all these developments into upstream?

>From our side: definitely! Everything is posted here on the lists when
it's in a state that we think we can show it to you folks.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
