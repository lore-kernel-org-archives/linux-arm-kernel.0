From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 12 Apr 2013 10:42:04 +0200
Subject: [GIT PULL v2] Reset controller API
In-Reply-To: <CAOesGMiyDvC7GXetEZY1Tp=s2jqvU_4gJhvgdYe5TUmdRaogsg@mail.gmail.com>
References: <1365495574.4023.32.camel@pizza.hi.pengutronix.de>
 <20130411102047.GA7437@quad.lixom.net>
 <CAOesGMidoasD35LL4VvCUPwTPrrRE9hxPGUVmuGQtuvH_nxs0g@mail.gmail.com>
 <1365683829.4388.52.camel@pizza.hi.pengutronix.de>
 <20130411171443.GB31066@quad.lixom.net>
 <20130412000340.GA16970@S2101-09.ap.freescale.net>
 <CAOesGMiyDvC7GXetEZY1Tp=s2jqvU_4gJhvgdYe5TUmdRaogsg@mail.gmail.com>
Message-ID: <1365756124.5330.9.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 11.04.2013, 17:15 -0700 schrieb Olof Johansson:
> On Thu, Apr 11, 2013 at 5:03 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Thu, Apr 11, 2013 at 10:14:43AM -0700, Olof Johansson wrote:
> >> On Thu, Apr 11, 2013 at 02:37:09PM +0200, Philipp Zabel wrote:
> >> > Hi Olof,
> >> >
> >> > Am Donnerstag, den 11.04.2013, 03:25 -0700 schrieb Olof Johansson:
> >> > > On Thu, Apr 11, 2013 at 3:20 AM, Olof Johansson <olof@lixom.net> wrote:
> >> > > > On Tue, Apr 09, 2013 at 10:19:34AM +0200, Philipp Zabel wrote:
> >> > > >> Hi Olof,
> >> > > >>
> >> > > >> I have added two fixes on top of the reset series at
> >> > > >> git://git.pengutronix.de/git/pza/linux.git reset/for_v3.10.
> >> > > >> Could you pull them in together with the rest?
> >> > > >>
> >> > > >> The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:
> >> > > >>
> >> > > >>   Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)
> >> > > >>
> >> > > >> are available in the git repository at:
> >> > > >>
> >> > > >>   git://git.pengutronix.de/git/pza/linux.git reset/for_v3.10
> >> > > >>
> >> > > >> for you to fetch changes up to fbdb93ecb869f02a5f8f145fa06a0984c415a7d4:
> >> > > >>
> >> > > >>   Documentation: gpio-reset.txt: Fix 'initially-in-reset' example (2013-04-09 09:55:00 +0200)
> >> > > >>
> >> > > >> They add a simple API for devices to request being reset by separate
> >> > > >> reset controller hardware and implement the reset signal device tree
> >> > > >> bindings proposed by Stephen Warren.
> >> > > >> The patches have been discussed on the linux-arm-kernel list under the topic
> >> > > >> "Reset controller API to reset IP modules on i.MX5 and i.MX6".
> >> > > >>
> >> > > >> ----------------------------------------------------------------
> >> > > >> Dan Carpenter (1):
> >> > > >>       reset: NULL deref on allocation failure
> >> > > >>
> >> > > >> Fabio Estevam (1):
> >> > > >>       Documentation: gpio-reset.txt: Fix 'initially-in-reset' example
> >> > > >>
> >> > > >> Philipp Zabel (2):
> >> > > >>       reset: Add reset controller API
> >> > > >>       reset: Add driver for gpio-controlled reset pins
> >> > > >>
> >> > > >> Stephen Warren (1):
> >> > > >>       dt: describe base reset signal binding
> >> > > >
> >> > > > Hmm, I don't see an ack or reviewed-by on these subsystem bindings from
> >> > > > neither Rob nor Grant.
> >> > > >
> >> > > > Since it's a brand new subsystem binding, I'd like to see them ack it
> >> > > > before we pick it up.
> >> > >
> >> > > Sigh. Ok, so I now stumbled across the Ack from Rob that you didn't
> >> > > pick up. Don't do it like that again, please. If Shawn prematurely
> >> > > bases his code on top of unacked patches, then that's his problem, not
> >> > > yours.
> >> >
> >> > Sorry I didn't notice that Rob's ack didn't have you in Cc. So shall I
> >> > leave the dt binding patch untouched this time? I'll take note of this
> >> > for the future.
> >>
> >> See below.
> >>
> >> > > The problem still remains though, since the gpio-reset binding hasn't
> >> > > seen an ack on the list, as far as I can tell. And I'll have a comment
> >> > > on that as well in a minute, see separate reply on that patch.
> >> >
> >> > Ok. What would you have me do now? I could revert the gpio-reset patch
> >> > (possibly asking Shawn to pull that, too), and have it do another round
> >> > on the list instead. Or I could address your comments with a relative
> >> > patch, and put that on top.
> >>
> >> This is a case where rebase is fine, as far as I am concerned. Just tell
> >> Shawn to also rebase his dependent code accordingly. That way you can
> >> add Rob's ack too.
> >>
> >> Once the bindings have been ironed out you can add it back, but that's looking
> >> like 3.11 material now.
> >
> > Just to be clear, you are asking Philipp to move patch "reset: Add
> > driver for gpio-controlled reset pins" out (leave it for 3.11), and add
> > Rob's ACK on patch "dt: describe base reset signal binding", and then
> > resend the pull request. Is it correct?
> 
> Yep! We'll stage it as a late branch.

Ok, I've rebased the branch at
    git://git.pengutronix.de/git/pza/linux.git reset/for_v3.10

These gpio-reset patches are dropped:
    reset: Add driver for gpio-controlled reset pins
    Documentation: gpio-reset.txt: Fix 'initially-in-reset' example

And the binding patch
    dt: describe base reset signal binding
now contains Rob's ack.

regards
Philipp
