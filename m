From: inki.dae@samsung.com (In-Ki Dae)
Date: Fri, 02 Jul 2010 07:50:53 +0000 (GMT)
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-ID: <25797910.38561278057053699.JavaMail.weblogic@epml17>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, I understood.

I think this issue incompatible with existing users is because userspace API didn't consider cpu mode before.
anyway, I will correct my patch as your comments and send it again.
Perhaps, cpu timing variables would be moved to platform file.

thank you.

------- Original Message -------
Sender : Russell King - ARM Linux<linux@arm.linux.org.uk> 
Date   : 2010-07-02 16:30 (GMT+09:00)
Title  : Re: [PATCH 1/3] FB: Add some members for CPU Interface.

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
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
