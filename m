From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Apr 2013 08:50:31 +0200
Subject: [PATCH V2 08/12] spi/mxs: Fix race in setup method
In-Reply-To: <CA+7tXih2r6YFE80y7z7Nj7c0Ytvh+v56-SrbS+VQ7kCW3KBRXA@mail.gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <201304030427.41297.marex@denx.de>
 <CA+7tXih2r6YFE80y7z7Nj7c0Ytvh+v56-SrbS+VQ7kCW3KBRXA@mail.gmail.com>
Message-ID: <201304030850.31752.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> On Apr 2, 2013 7:27 PM, "Marek Vasut" <marex@denx.de> wrote:
> > > The only useful thing mxs_spi_setup_transfer() (which
> > > is no longer called) did in this instance was make that check.
> > > 
> > > > btw. I was under the impression the MXS SSP block can handle other
> > > > word-widths than 8 bit, no ?
> > > 
> > > In theory it can,
> > 
> > In practice too ;-)
> > 
> > > however the driver only supports 8-bits and will
> > > reject anything else.
> > 
> > Then please at least add a comment about this.
> 
> What does that have to do with this patch?

You're adding a piece of code. This change is
a) not documented in the commit message
b) unrelated to this fix, seems to be more fitting in 10/12 or something -- 
maybe even shuffling the patches a bit might help

So add a comment to make this clearer for people who hack on this after you.

> There was no comment about
> it before.  You're insisting that changes be broken up to the extent
> that changing one line of code takes multiple patches!  Now you want a
> comment about existing driver behavior added to patch that doesn't
> change that behavior?
> 
> Documenting the driver behavior would seem to be a job for the driver
> maintainer.  If doing this is something I need to do, then maybe I
> should maintain it?

You ain't rubbing people the right way at all, I tell you. This pushy/offensive 
behavior helps noone, calm down please. It is usually a good idea to sleep on 
your reply or take your time.

Ad maintainership -- there's no maintainer of the driver, there's only Fabio, 
Shawn, me and the SPI subsystem guys. And it works well. It's everybodys' code 
and everyone's welcome to contribute. What's the problem? 

Best regards,
Marek Vasut
