From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 1 Dec 2012 13:26:34 +0000
Subject: [PATCH 2/2] i2c-s3c2410: Add bus arbitration implementation
In-Reply-To: <CAOesGMgE0JEHsdySpua34_kbWi1+z4n4UdW0kumiJEROi7O2pQ@mail.gmail.com>
References: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
 <1354165536-18529-3-git-send-email-ch.naveen@samsung.com>
 <20121129163448.GA3761@sirena.org.uk>
 <CAPnjgZ0atD3k=gT0vjgkLO_SA8DMak6SiT6nZ_2T6WFqtK0szQ@mail.gmail.com>
 <CAOesGMgE0JEHsdySpua34_kbWi1+z4n4UdW0kumiJEROi7O2pQ@mail.gmail.com>
Message-ID: <20121201132632.GA17981@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 10:14:58PM -0800, Olof Johansson wrote:
> On Thu, Nov 29, 2012 at 6:13 PM, Simon Glass <sjg@chromium.org> wrote:

> > It was originally done separately but I think it was felt that this
> > was overly complex. Olof can you please comment on this?

> it is indeed not controller specific per se, but we are unaware of any
> other platform/driver using it. So, it seemed reasonable to implement
> it in the driver as long as we have only one user; if another one
> comes along it's of course better to move it to the common i2c code.

> At least that was my opinion at the time. I could be convinced
> otherwise if someone else has strong opinions on the matter.

This sort of approach is half the reason SPI ended up being so fun...  I
suspect if you look hard enough you'll find that this is just the first
time someone tried to upstream such a scheme.  This is all especially
true for the DT bindings, even if the implementation is driver local for
now it'd be better to define generic bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121201/67e3ccb9/attachment.sig>
