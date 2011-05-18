From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 18 May 2011 14:22:45 -0600
Subject: [RFC PATCH] drivers/amba: probe via device tree reworked
In-Reply-To: <4DD4205E.9040705@gmail.com>
References: <1305742487-28325-1-git-send-email-robherring2@gmail.com>
	<20110518184753.GB25861@ponder.secretlab.ca>
	<4DD4205E.9040705@gmail.com>
Message-ID: <20110518202245.GC25861@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 02:39:10PM -0500, Rob Herring wrote:
> On 05/18/2011 01:47 PM, Grant Likely wrote:
> >On Wed, May 18, 2011 at 01:14:47PM -0500, Rob Herring wrote:
> >>From: Rob Herring<rob.herring@calxeda.com>
> >>
> >>This reworks the original amba bus device tree probing to be more inline with
> >>how platform bus probing via device tree is done using a match table.
> >
> >You should also mention that this patch builds on the code currently
> >in devicetree/test on git://git.secretlab.ca/git/linux-2.6.  Otherwise
> >people will be very confused about what this applies to.
> >
> 
> Yeah. I was ultimately expecting to squash this one into the first
> amba bus patch assuming you agree with the general direction. Would
> you rather me combine it and send that out instead of an incremental
> patch?

yes.

> 
> >>The amba bus code doesn't support creation of parent devices, so a flat tree
> >>is created even if the device tree contains a heirarchy of devices.
> >
> >Hmmm, why do you say this?  The code doesn't currently set the parent
> >pointer, but nothing prevents a caller of amba_device_register() from
> >setting the parent pointer before it is registered.  I also don't see
> >anything in the amba bus code that assume it must all be flat in the
> >driver model.  What bit am I missing?
> 
> The problem is not setting a parent pointer. That can be passed in.
> The problem I had was creating an amba_device for the bus, but your
> comment below to use a platform device clarifies that issue.

okay, good.

g.
