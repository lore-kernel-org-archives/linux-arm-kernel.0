From: tpiepho@gmail.com (Trent Piepho)
Date: Tue, 2 Apr 2013 23:08:40 -0700
Subject: [PATCH V2 08/12] spi/mxs: Fix race in setup method
In-Reply-To: <201304030427.41297.marex@denx.de>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <201304030131.37782.marex@denx.de>
 <CA+7tXigasUbSRD6hQH66m6XsDkzS9ubLSB24f4akB3pv9xrT=A@mail.gmail.com>
 <201304030427.41297.marex@denx.de>
Message-ID: <CA+7tXih2r6YFE80y7z7Nj7c0Ytvh+v56-SrbS+VQ7kCW3KBRXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 2, 2013 7:27 PM, "Marek Vasut" <marex@denx.de> wrote:
>
> > The only useful thing mxs_spi_setup_transfer() (which
> > is no longer called) did in this instance was make that check.
> >
> > > btw. I was under the impression the MXS SSP block can handle other
> > > word-widths than 8 bit, no ?
> >
> > In theory it can,
>
> In practice too ;-)
>
> > however the driver only supports 8-bits and will
> > reject anything else.
>
> Then please at least add a comment about this.

What does that have to do with this patch?  There was no comment about
it before.  You're insisting that changes be broken up to the extent
that changing one line of code takes multiple patches!  Now you want a
comment about existing driver behavior added to patch that doesn't
change that behavior?

Documenting the driver behavior would seem to be a job for the driver
maintainer.  If doing this is something I need to do, then maybe I
should maintain it?
