From: gregkh@suse.de (Greg KH)
Date: Fri, 18 Feb 2011 09:05:38 -0800
Subject: [PATCH 1/2] PRUSS UIO driver support
In-Reply-To: <20110218163147.GD4684@local>
References: <1298041530-26855-1-git-send-email-pratheesh@ti.com>
	<1298041530-26855-2-git-send-email-pratheesh@ti.com>
	<20110218163147.GD4684@local>
Message-ID: <20110218170538.GB11773@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 05:31:47PM +0100, Hans J. Koch wrote:
> On Fri, Feb 18, 2011 at 08:35:29PM +0530, Pratheesh Gangadhar wrote:
> > Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>

As noted by others, this needs to go at the end of the changelog
comment.

Also, always run your patches through the scripts/checkpatch.pl script
and fix the warnings and errors it finds.  To not do so is just rude as
you are asking us to do the basic review work that you yourself did not
do in the first place.

> > +static irqreturn_t pruss_handler(int irq, struct uio_info *dev_info)
> > +{
> > +	return IRQ_HANDLED;
> > +}
> 
> ROTFL. That reminds me of an old story. The last time I wrote this, and
> Greg dared to post it, we received this reply:
> 
> http://marc.info/?l=linux-kernel&m=116604101232144&w=2
> 
> So, if you really have a _very_ good reason why this _always_ works on
> _any_ DA850 board, add a comment that explains why. Otherwise the whole
> patch set will be doomed.

Nope, this whole patch set is doomed if this isn't fixed, I'm not going
to accept it no matter how much you want to try to say this is ok on
this hardware.

thanks,

greg k-h
