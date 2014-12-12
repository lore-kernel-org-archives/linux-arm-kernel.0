From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Dec 2014 00:24:10 +0000
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <CAD=FV=WBAuF0+BVMG9rp53Zt851Ou0kZ6xgTe9mjmgxyugWteg@mail.gmail.com>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
 <20141210235347.GT11764@sirena.org.uk>
 <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
 <20141211123106.GU11764@sirena.org.uk>
 <CAD=FV=U4RFYx9NXOACrXJZK2bKkosyYnmTZRHkXuaSz-FS9kNQ@mail.gmail.com>
 <20141211170934.GZ11764@sirena.org.uk>
 <CAD=FV=WBAuF0+BVMG9rp53Zt851Ou0kZ6xgTe9mjmgxyugWteg@mail.gmail.com>
Message-ID: <20141212002410.GB11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 11:55:55AM -0800, Doug Anderson wrote:
> On Thu, Dec 11, 2014 at 9:09 AM, Mark Brown <broonie@kernel.org> wrote:

> > Please also bear in mind the need to handle shared supplies in your
> > implementation.

> I'm being dense, can you give more details?  Do you want me to grab
> the mutex or do something smarter like track the voltage / tolerance
> requested by multiple clients and resolve them, or ...?

I mean the latter - what happens if more than one consumer is trying to
use the regulator?  This is IIRC why _set_voltage_tol() uses the cheap
and nasty implementation it does.  There's also the potential
performance considerations for the DVS type applications now I think
about it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/5cf82a4d/attachment.sig>
