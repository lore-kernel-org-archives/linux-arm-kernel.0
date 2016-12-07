From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 7 Dec 2016 13:57:40 +0000
Subject: [PATCHv4 09/10] mm/usercopy: Switch to using lm_alias
In-Reply-To: <CAGXu5jKTdZUbbHU91mbN+Qy80AGXRhpzdLNXr3oxxZyxAzmjmQ@mail.gmail.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-10-git-send-email-labbott@redhat.com>
 <CAGXu5jKrBc6R9JYay1L6pd958Vm5-6p=37tiUYgg6uPeZb1HtQ@mail.gmail.com>
 <20161206181859.GH24177@leverpostej>
 <CAGXu5jKTdZUbbHU91mbN+Qy80AGXRhpzdLNXr3oxxZyxAzmjmQ@mail.gmail.com>
Message-ID: <20161207135740.GB25605@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 12:10:50PM -0800, Kees Cook wrote:
> On Tue, Dec 6, 2016 at 10:18 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Nov 29, 2016 at 11:39:44AM -0800, Kees Cook wrote:
> >> On Tue, Nov 29, 2016 at 10:55 AM, Laura Abbott <labbott@redhat.com> wrote:
> >> >
> >> > The usercopy checking code currently calls __va(__pa(...)) to check for
> >> > aliases on symbols. Switch to using lm_alias instead.
> >> >
> >> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> >>
> >> Acked-by: Kees Cook <keescook@chromium.org>
> >>
> >> I should probably add a corresponding alias test to lkdtm...
> >>
> >> -Kees
> >
> > Something like the below?
> >
> > It uses lm_alias(), so it depends on Laura's patches. We seem to do the
> > right thing, anyhow:
> 
> Cool, this looks good. What happens on systems without an alias?

In that case, lm_alias() should be an identity function, and we'll just
hit the usual kernel address (i.e. it should be identical to
USERCOPY_KERNEL).

> Laura, feel free to add this to your series:
> 
> Acked-by: Kees Cook <keescook@chromium.org>

I'm happy with that, or I can resend this as a proper patch once the
rest is in.

Thanks,
Mark.
