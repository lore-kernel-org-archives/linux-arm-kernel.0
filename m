From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2012 11:24:01 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: move mailbox.h out of plat-omap headers
In-Reply-To: <5090E515.9050407@st.com>
References: <1351530381-11459-1-git-send-email-omar.luna@linaro.org>
 <1351530381-11459-2-git-send-email-omar.luna@linaro.org>
 <20121029175228.GD11908@atomide.com>
 <CALLhW=4ukBuRSVcPm2A37PgBhv33yKqk2G=Dz2XTUyswXw=JMg@mail.gmail.com>
 <20121030162441.GF11908@atomide.com>
 <20121030210213.GA6098@kroah.com>
 <CALLhW=6p06MPdfbD2S-PRs=w0zLNsEifsJ2xL0hjEZaFpbadDA@mail.gmail.com>
 <5090E515.9050407@st.com>
Message-ID: <20121031182401.GM12739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Loic PALLARDY <loic.pallardy@st.com> [121031 01:48]:
> 
> Hi Omar,
> 
> On 10/31/2012 08:22 AM, Omar Ramirez Luna wrote:
> >
> > As part of plat-omap code cleanup, I was planning to move omap-mailbox
> > framework to a newly drivers/mailbox folder, right now this code is
> > specific to OMAP platforms, but with some clean up it could be the
> > base for a generic framework. And living under drivers/mailbox could
> > give it some exposure for interested developers to give feedback and
> > propose changes.
> >
> > In the past there was a mailbox-like driver in mach-ux500, I was
> > hoping both could live under the same folder, however the platform
> > using it, was dropped a couple of kernel releases back and with it the
> > other similar mailbox implementation.
> 
> On STE side, we are working on a mailbox driver which will rely on 
> mailbox framework.
> However some modifications in current Omap mailbox framework are needed 
> to fit STE HW specificities.
> - API naming should be generic (replace omap prefix by mailbox)
> - message type should be enhanced
> - fifo mechanism is linked to Omap maibox, not needed in STE case since 
> it relies on cross interrupt + shared memory
> I already have modifications I'll send you to see how we can create a 
> common and generic mailbox framework.

OK cool. How about Omar first posts the fixed minimal patches
to move things to live under drivers so can fix up omap for
ARCH_MULTIPLATFORM?

I can then put just those into an immutable branch that people
can pull in as needed, and you guys can continue from there with
the common mailbox framework (and I can continue work on the
core omap code independently of the mailbox framwork work).

Regards,

Tony
