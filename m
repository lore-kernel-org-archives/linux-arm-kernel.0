From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Dec 2014 13:13:24 +0000
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <CAD=FV=UfKAduhzs5-EJFZDgv-kv=rzMzuzT5N97ogdno66PqYw@mail.gmail.com>
References: <20141210235347.GT11764@sirena.org.uk>
 <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
 <20141211123106.GU11764@sirena.org.uk>
 <CAD=FV=U4RFYx9NXOACrXJZK2bKkosyYnmTZRHkXuaSz-FS9kNQ@mail.gmail.com>
 <20141211170934.GZ11764@sirena.org.uk>
 <CAD=FV=WBAuF0+BVMG9rp53Zt851Ou0kZ6xgTe9mjmgxyugWteg@mail.gmail.com>
 <20141212002410.GB11764@sirena.org.uk>
 <CAD=FV=W1r2MXNHXTRiO1pBPWurvgqq+dSoOPgpSJ_zAbpU7T4Q@mail.gmail.com>
 <20141212125951.GE11764@sirena.org.uk>
 <CAD=FV=UfKAduhzs5-EJFZDgv-kv=rzMzuzT5N97ogdno66PqYw@mail.gmail.com>
Message-ID: <20141216131324.GS11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 02:11:02PM -0800, Doug Anderson wrote:
> On Fri, Dec 12, 2014 at 4:59 AM, Mark Brown <broonie@kernel.org> wrote:

> > Perhaps doing something based on the various factorings out of the
> > voltage mapping would do the trick, add a new op for getting to the
> > closest voltage?

> I'd really rather add a new op because I think it would mean that all
> the old regulators that don't implement the op would be slow all of a
> sudden.  :(

Assuming there's a not missing there...  I don't think it's quite that
bad, most regulators do use one of the standard mapping functions and
for those that are likely to matter for performance there's usually a
calculation rather than a lookup table.  That said...

> I looked at trying to refactor everything, but I think the answer is
> that I should drop my patch and consider the existing
> regulator_set_voltage_tol() experience good enough.  While I could go
> through and try to make regulator_set_voltage_tol() better:

...I do agree that the current situation is probably adequate though,
the optimisation would be nice but it's mainly going to benefit corner
cases.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141216/39caea14/attachment.sig>
