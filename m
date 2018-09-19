From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Sep 2018 11:38:18 +0200
Subject: [PATCH V6] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <70fff432-001e-7161-ab47-b600161ec257@gmail.com>
References: <20180918122340.5478-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVOMZ+o4osu7zGJm3YBQ-Mxest1kkJGgiH53joW1i__jg@mail.gmail.com>
 <20180919091330.yxnehm2fy5llb2bb@verge.net.au>
 <7d214a60-e703-c53d-5c98-5da29c34650f@gmail.com>
 <CAMuHMdWdxFNuPkbXCigw_K8G9NR0r+V1hqbq1TBXM6rJxh5bAw@mail.gmail.com>
 <CAMuHMdVR-P-3s6Z0=GSa310ty+cqQk0WOO3w7+ZgiwkAt0Riiw@mail.gmail.com>
 <70fff432-001e-7161-ab47-b600161ec257@gmail.com>
Message-ID: <CAMuHMdXYg99MyCdSTSqEwmeSLotT3dCmCwcwhHMv23rH4y7_Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Wed, Sep 19, 2018 at 11:36 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 09/19/2018 11:30 AM, Geert Uytterhoeven wrote:
> > On Wed, Sep 19, 2018 at 11:28 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> On Wed, Sep 19, 2018 at 11:22 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> >>> On 09/19/2018 11:13 AM, Simon Horman wrote:
> >>>> Marek, these days checkpatch complains if the author of the patch does not
> >>>> have a signed offline, and the inconsistency between your
> >>>> from and Sign-off the email address trips that check.
> >>>>
> >>>> Could you consider either a) enhancing checkpatch or b) using
> >>
> >> I'm the one who enhanced checkpatch with the new check ;-)
> >>
> >>>> the same address twice? No need to take any action for this patch.
> >>>
> >>> Sure, do you know if there's some tweak to git config , so git
> >>> send-email uses the m.v+foo@ From address ?
> >>
> >> Git send-email uses the address from user.email in gitconfig, just
> >> like git commit.
> >>
> >> However, I see you're using Gmail's SMTP server. That one replaces the
> >> From-line in the header by your primary email address as configured in Gmail
> >> (even if you have configured Gmail to know the other address is yours, too).
> >>
> >> I use my ISP's SMTP server to work around that.
> >
> > Another trick that should work:
> >
> > If you run git send-email in a repo with a different user.email
> > config, it should
> > add the original From to the email's body, as it will detect you're submitting
> > patches on behalf of "someone else".
>
> Or I can just patch in the From field myself before sending , just like
> Cc: and SoB ?

You can try, but I'm afraid git is too smart, and will remove it as considered
unneeded.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
