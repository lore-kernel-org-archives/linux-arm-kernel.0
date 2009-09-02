From: dave@chronolytics.com (David F. Carlson)
Date: Wed, 2 Sep 2009 17:25:36 -0400 (EDT)
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902161252.GD2367@trinity.fluff.org>
Message-ID: <200909022125.n82LPaVP029138@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry about my long line formatting...

According to Ben Dooks:
> 
> > === video / multimedia ===
> > * needs a lot of thought
> > * support standard mainlien architecture wherever possible
> > ** 2D accelerated framebuffer
> > ** DRI/DRM/TTM/KMS
> > ** V4L
> 
> I am not really sure if there is any current support for using
> hardware blocks for decoding video data. I think that having some
> form of framework for doing these as well as allowing blocks to be
> chained togehter would be useful.
> 
> Again this is something that needs to be taken up with the relevant
> community (assuming there is one) to come to a good solution.
>  

I have source to a mplayer which uses the MFC/PP as the video codec for the 
four video encodings it supports.  A hd video with MFC decode utilizes ~30% of 
the 6410 and without the HW assist utilizes all the CPU and still drops 
frames.  This is all within Xwin using the fbdev.

This MFC/PP driver pair is useful to users now.  I am sorry they are not 
good enough for the next-s3c.

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll
