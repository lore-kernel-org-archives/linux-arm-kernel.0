From: greg@kroah.com (Greg KH)
Date: Sat, 26 Nov 2011 07:04:18 -0800
Subject: [PATCH 3/3] drivers/misc: introduce face detection module
 driver(fdif)
In-Reply-To: <20111126111247.43cb5d35@lxorguk.ukuu.org.uk>
References: <1322281904-14526-1-git-send-email-tom.leiming@gmail.com>
 <1322281904-14526-4-git-send-email-tom.leiming@gmail.com>
 <20111126111247.43cb5d35@lxorguk.ukuu.org.uk>
Message-ID: <20111126150418.GA11680@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 11:12:47AM +0000, Alan Cox wrote:
> On Sat, 26 Nov 2011 12:31:44 +0800
> tom.leiming at gmail.com wrote:
> 
> > From: Ming Lei <ming.lei@canonical.com>
> > 
> > One face detection IP[1] is integared inside OMAP4 SoC, so
> > introduce this driver to make face detection function work
> > on OMAP4 SoC.
> > 
> > This driver is platform independent, so in theory can
> > be used to drive same IP module on other platforms.
> > 
> > [1], ch9 of OMAP4 TRM
> > 
> > Signed-off-by: Ming Lei <ming.lei@canonical.com>
> 
> If you are submitting it then it ought to have your sign off too. This
> looks hardly ready for submission however.
> 
> > +config FDIF
> > +	tristate "Face Detection module"
> > +	help
> > +	  The FDIF is a face detection module, which can be integrated into
> > +	  SoCs to detect the location of human beings' face in one image. At
> > +	  least now, TI OMAP4 has the module inside.
> 
> So we have a completelt device specific API for what is becoming a more
> general feature and on some hardware is tied to camera and the like. This
> seems wrong
> 
> IMHO this should be part of video4linux because that'll make the
> integrated stuff work sanely and for your cases it still provided the
> right kind of mmap and format interfaces you need.

I agree, as-is, this isn't ok, sorry, please work with the v4l
developers on this.

greg k-h
