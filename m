From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Dec 2014 17:09:34 +0000
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <CAD=FV=U4RFYx9NXOACrXJZK2bKkosyYnmTZRHkXuaSz-FS9kNQ@mail.gmail.com>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
 <20141210235347.GT11764@sirena.org.uk>
 <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
 <20141211123106.GU11764@sirena.org.uk>
 <CAD=FV=U4RFYx9NXOACrXJZK2bKkosyYnmTZRHkXuaSz-FS9kNQ@mail.gmail.com>
Message-ID: <20141211170934.GZ11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 08:09:13AM -0800, Doug Anderson wrote:
> On Thu, Dec 11, 2014 at 4:31 AM, Mark Brown <broonie@kernel.org> wrote:

> > This is just an implementation detail, everything you're saying here
> > applies equally to any user specifying by tolerance rather than range.
> > If the reason for doing this is to fix that problem then a new API isn't
> > the way to go about it.

> OK, I'll give a shot at taking my code and using it as a new
> implementation for regulator_set_voltage_tol().  In the SD card code
> I'll pick some reasonable tolerances--they won't be exactly what the
> spec says, but they ought to be good enough.  If Ulf comes back and
> yells at me then we can revisit adding a new API.

OK, thanks.  Even if a new interface does get added the implementation
needs to be shared with that for setting by tolerance, they're doing the
same thing.

Please also bear in mind the need to handle shared supplies in your
implementation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/f1c36788/attachment.sig>
