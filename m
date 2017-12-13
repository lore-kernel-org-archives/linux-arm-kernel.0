From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 13 Dec 2017 09:39:46 +0100
Subject: Lithium battery protection was Re: [PATCH v4.14] Add support for
 bq27521 battery monitor
In-Reply-To: <20171208170610.gbmlsgm7xzh2zpyn@earth>
References: <20171109210615.GA27638@amd> <20171110103937.GA29900@amd>
 <20171201230649.GA27533@amd>
 <cfa89227-e08a-849f-c886-723268ae657c@ti.com>
 <20171208170610.gbmlsgm7xzh2zpyn@earth>
Message-ID: <20171213083946.GA26605@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > >> This adds basic support for BQ27521 battery monitor, used in Nokia N9
> > >> and N950. In particular, battery voltage is important to be able to
> > >> tell when the battery is almost empty. Emptying battery on N950 is
> > >> pretty painful, as flasher needs to be used to recover phone in such
> > >> case.
> > > 
> > > Sebastian, ping? This one should not be too controversial.
> >
> > Acked-by: Andrew F. Davis <afd@ti.com>
> 
> Thanks, queued, I dropped the spurious change in twl.h and added the
> dt-binding from the previous patch version, that was lost somehow.

Thanks!

> > > If you could also apply the "shut down when battery is low", that
> > > would be nice.
> 
> I only have one with values specific to N900 hardcoded in the
> driver. That one can't be applied for obvious reasons.

Well... the values are not really N900-specific. They should work well
on anything with lithium battery, because they basically depend only
on battery chemistry.

I guess I can simplify patch to work with battery voltage only --
that's what hardware battery protection does -- and make shutdown
voltage configurable ...?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/5571e850/attachment.sig>
