From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Jun 2013 10:10:34 +0900
Subject: [PATCH 09/12] ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM
In-Reply-To: <CABYn4syfNmb6RmG83Pkke2fK1Z8GC8x9Jv0=woazdiJQ+fVXWw@mail.gmail.com>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-10-git-send-email-horms+renesas@verge.net.au>
 <20130528035019.GI13532@quad.lixom.net>
 <20130604050915.GU23054@verge.net.au>
 <CABYn4syfNmb6RmG83Pkke2fK1Z8GC8x9Jv0=woazdiJQ+fVXWw@mail.gmail.com>
Message-ID: <20130606011033.GA21025@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bastian,

I wasn't implying that I have rejected these patches outright,
I apologise if that is the way that I cam across. Rather, that
they seem to need a little more work.

* ARM: shmobile: r8a7740: Add CPUIdle

  There was some discussion in a different sub-thread
  that this should be Acked by Rafael and possibly go through
  his tree. Could you talk with Rafael about his feelings
  with regards to both of these.

* ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM

  I'm unclear if this is also in Rafael's domain or not,
  but as it depends on the first patch it seems as well
  to talk post it to Rafael with the other patch for his
  consideration.

  This patch also seems to have some minor problems.

  1. When you repost could you please squash in the fix
     provided by Arnd as "ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM".

  2. As noticed by Olof, v7_cpu_resume needs a different name.
     I believe you have already proposed a trivial fix for this.

On Tue, Jun 04, 2013 at 05:34:30PM +0200, Bastian Hecht wrote:
> Hi Simon,
> 
> quite some effort has gone into this patch. People from ARM Ltd. have
> discussed issues about the shutdown in other threads and I spent quite
> some time on it. What are the problems? Are we concerned about the
> stability of our system? The CPUIdle feature shut down my r8a7740 on
> the Armadillo board more than 1 million times successfully. Further
> CPUIdle is deselected as default config anyway. And single
> suspend/resume cycles should be even less problematic.
> 
> Thanks,
> 
>  Bastian
> 
> 
> 2013/6/4 Simon Horman <horms@verge.net.au>:
> > On Mon, May 27, 2013 at 08:50:19PM -0700, Olof Johansson wrote:
> >> Hi,
> >>
> >> On Mon, May 27, 2013 at 05:59:50PM +0900, Simon Horman wrote:
> >> > From: Bastian Hecht <hechtb@gmail.com>
> >> >
> >> > We add 2 Suspend to RAM modes:
> >> > - A3SM PLL0 on/off:     Power domain A3SM that contains the ARM core
> >> >                         and the 2nd level cache with either PLL0 on
> >> >                         or off
> >> >
> >> > As the suspend to memory mechanism we use A3SM PLL off. A3SM PLL on
> >> > is included here too, so CPUIdle can use both power down modes (not
> >> > included in this patch).
> >> >
> >> > The setup of the SYSC regarding the external IRQs is taken from
> >> > pm-sh7372.c from Magnus Damm.
> >> >
> >> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> >>
> >> Missing S-o-b from you, Simon?
> >>
> >> > +   .text
> >> > +ENTRY(v7_cpu_resume)
> >> > +   bl      v7_invalidate_l1
> >> > +   b       cpu_resume
> >> > +ENDPROC(v7_cpu_resume)
> >>
> >> This is a global namespace so it'll conflict with i.MX whenever
> >> you multiplatform enable shmobile. Might want to pick a more
> >> unique name.
> >
> > I have decided to drop this and related cpuidle and suspend-to-ram
> > patches for r8a7740 after discussion with Magnus.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
