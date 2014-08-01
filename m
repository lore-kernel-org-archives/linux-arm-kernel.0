From: mporter@linaro.org (Matt Porter)
Date: Fri, 1 Aug 2014 15:46:57 -0400
Subject: [PATCH v8 01/11] ARM: brcmstb: add infrastructure for ARM-based
 Broadcom STB SoCs
In-Reply-To: <CAGVrzcaEV81BW+a--QgQSHiLb6UQDFsP3cqQxGwV206MRx4gXw@mail.gmail.com>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <1405976886-27807-2-git-send-email-computersforpeace@gmail.com>
 <CAL_Jsq+Nbk7m9KXhG+Chdpvurp75RrvhFR2oE_LGxV444GSe9Q@mail.gmail.com>
 <20140731022320.GM3711@ld-irv-0074>
 <CAL_Jsq+47YtqWwOkxYDzaEOG-+oouvpXvmGaX+Wh3wQ+BNAx_w@mail.gmail.com>
 <CAGVrzcaEV81BW+a--QgQSHiLb6UQDFsP3cqQxGwV206MRx4gXw@mail.gmail.com>
Message-ID: <20140801194657.GJ2593@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 12:29:11PM -0700, Florian Fainelli wrote:
> Hello,
> 
> 2014-08-01 7:33 GMT-07:00 Rob Herring <robherring2@gmail.com>:
> > On Wed, Jul 30, 2014 at 9:23 PM, Brian Norris
> > <computersforpeace@gmail.com> wrote:
> >> Hi Rob,
> >>
> >> I appreciate your comments, but where were many of these 5 months ago on
> >> the first 7 revisions? :)
> >
> > Sorry, but that is the nature of upstreaming. But given some of the
> > issues, it is obvious the reviews were not sufficient.
> >
> >> On a practical note: v9 is already queued for 3.17. Should I send
> >> patches for the 3.17 cycle (or later) to fixup some of these issues? Or
> >> would you recommend pulling the patches out of Matt Porter's tree now,
> >> and reintroducing for 3.18? (I would be much happier with the first.)
> >
> > Things can always be un-queued. I guess that's Matt's and arm-soc's decision.
> 
> Does that mean we should get all those patches un-queued, because that
> specific patch adding SMP support that needs to be reworked, or does
> that mean that if we drop this specific patch we are good with the
> remainder of the patch series?

Well, keep in mind that there's no specific patch adding SMP support.
The patch here contains *all* of the actual code that goes through
mach-bcm. The rest will go through Russell.

Given what was missed, if we drop just this patch, we're left with just
the DT, Kconfig, and MAINTAINERS changes. It doesn't seem like there's
time to fix the problems now. It might be better to drop the whole
series from arm-soc since it won't be functional in 3.17 if we drop
just this patch. I'd like to see what Arnd and Olof think. I think
there's value in leaving all the DT bits for 3.17.

-Matt
