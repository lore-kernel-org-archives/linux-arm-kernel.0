From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jul 2010 08:30:01 +0100
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
In-Reply-To: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
References: <4C29CFBD.3040205@samsung.com>
	<AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
Message-ID: <20100702073001.GA25492@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 08:02:31AM +0800, Jaya Kumar wrote:
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 907ace3..73381c3 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -269,6 +269,12 @@ struct fb_var_screeninfo {
> >  	__u32 vmode;			/* see FB_VMODE_*		*/
> >  	__u32 rotate;			/* angle we rotate counter clockwise */
> >  	__u32 reserved[5];		/* Reserved for future compatibility */
> > +
> > +	/* For cpu interface timing. */
> > +	__u32 cs_setup;
> > +	__u32 wr_setup;
> > +	__u32 wr_act;
> > +	__u32 wr_hold;

This changes the framebuffer userspace API, making it incompatible with
existing users.  What this means is that stuff using the framebuffer API
in userspace has to be upgraded/downgraded in lock-step with this change
- which is not a good idea.
