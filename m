From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Mar 2016 18:17:14 +0000
Subject: [PATCHv2 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
In-Reply-To: <CAG_fn=VBOqPSwhKy2OCj7cgM=XaD338L=UfPDcg9X3tCwc6B_g@mail.gmail.com>
References: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
 <CAG_fn=WAfu4oD1Qb1xUnX765RpUznWm1y+FKYqqiM8VO53F+Ag@mail.gmail.com>
 <20160303174015.GG19139@leverpostej>
 <CAG_fn=VBOqPSwhKy2OCj7cgM=XaD338L=UfPDcg9X3tCwc6B_g@mail.gmail.com>
Message-ID: <20160303181714.GH19139@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 06:45:55PM +0100, Alexander Potapenko wrote:
> On Thu, Mar 3, 2016 at 6:40 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi,
> >
> > On Thu, Mar 03, 2016 at 06:17:31PM +0100, Alexander Potapenko wrote:
> >> Please replace "ASAN" with "KASAN".
> >>
> >> On Thu, Mar 3, 2016 at 5:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > Functions which the compiler has instrumented for ASAN place poison on
> >> > the stack shadow upon entry and remove this poison prior to returning.

[...]

> > For the above, and the rest of the series, ASAN consistently refers to
> > the compiler AddressSanitizer feature, and KASAN consistently refers to
> > the Linux-specific infrastructure. A simple s/[^K]ASAN/KASAN/ would
> > arguably be wrong (e.g. when referring to GCC behaviour above).
> I don't think there's been any convention about the compiler feature
> name, we usually talked about ASan as a userspace tool and KASAN as a
> kernel-space one, although they share the compiler part.

Ah, ok.

In future I'll speak in terms of "AddressSanitizer instrumentation" or
something like that, as that's fairly unambigious.

> > If there is a this needs rework, then I'm happy to s/[^K]ASAN/ASan/ to
> > follow the usual ASan naming convention and avoid confusion. Otherwise,
> > spinning a v3 is simply churn.
> I don't insist on changing this, I should've chimed in before.
> Feel free to retain the above patch description.

No worries, thanks for the info.

Thanks,
Mark.
