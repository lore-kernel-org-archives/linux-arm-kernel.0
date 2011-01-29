From: agust@denx.de (Anatolij Gustschin)
Date: Sat, 29 Jan 2011 20:24:09 +0100
Subject: [PATCH 1/2] v4l: soc-camera: start stream after queueing the
	buffers
In-Reply-To: <Pine.LNX.4.64.1101292015140.26696@axis700.grange>
References: <1296031789-1721-1-git-send-email-agust@denx.de>
	<1296031789-1721-2-git-send-email-agust@denx.de>
	<Pine.LNX.4.64.1101292015140.26696@axis700.grange>
Message-ID: <20110129202409.36307b2d@wker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 29 Jan 2011 20:16:42 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
...
> > --- a/drivers/media/video/soc_camera.c
> > +++ b/drivers/media/video/soc_camera.c
> > @@ -646,11 +646,11 @@ static int soc_camera_streamon(struct file *file, void *priv,
> >  	if (icd->streamer != file)
> >  		return -EBUSY;
> >  
> > -	v4l2_subdev_call(sd, video, s_stream, 1);
> > -
> >  	/* This calls buf_queue from host driver's videobuf_queue_ops */
> >  	ret = videobuf_streamon(&icd->vb_vidq);
> >  
> > +	v4l2_subdev_call(sd, video, s_stream, 1);
> > +
> 
> After a bit more testing I'll make this to
> 
> +	if (!ret)
> +		v4l2_subdev_call(sd, video, s_stream, 1);
> +
> 
> Ok? Or you can submit a v2 yourself, if you like - when you fix the 
> comment in the other patch from this series.

I'll submit a v2 patch since I have to resubmit the other patch, too.


Thanks,
Anatolij
