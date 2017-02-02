From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 2 Feb 2017 10:02:16 +0100
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <1485975894.2560.13.camel@perches.com>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
 <20161019155658.GB4411@x4>
 <CA+55aFx=ZX=7u07R6zJ7fSw=zSQNaYqVX7R3LQs4riiEf+uA=A@mail.gmail.com>
 <20161019162222.GT9193@arm.com>
 <c578d5ac-ab8a-974a-bdd9-597b8c545583@redhat.com>
 <CAKv+Gu9G+r7eH0mhniH1+ucrHNiGBMFQdKfMOi=OmekapoBtUg@mail.gmail.com>
 <CAKv+Gu_kifdUOwKgGv1xqboPMjyYRhHwFXDye1HpBo9hQY+_Uw@mail.gmail.com>
 <1485975894.2560.13.camel@perches.com>
Message-ID: <20170202090216.GV6515@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 11:04:54AM -0800, Joe Perches wrote:
> > +#define order_base_2(n)                                \
> > +(                                              \
> > +       __builtin_constant_p(n) ? (             \
> > +               ((n) < 2) ? (n) :               \
> > +               ilog2((n) - 1) + 1) :           \
> > +       __order_base_2(n)                       \
> > + )
> 
> Does this work properly when n is a signed negative value?

Do you see it returning a complex number?
