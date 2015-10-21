From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Oct 2015 15:49:37 +0200
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <alpine.DEB.2.11.1510202121590.8159@nanos>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
Message-ID: <20151021154937.0684666d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, 20 Oct 2015 21:23:29 +0200 (CEST), Thomas Gleixner wrote:
> On Tue, 20 Oct 2015, Thomas Petazzoni wrote:
> > As discussed on IRC, another simpler (code line wise) solution is to
> > simply clear the IRQ_NOAUTOEN flag in the irq-armada-370-xp, which
> > brings us back to what set_irq_flags() was doing, without actually
> > reverting Rob's patch.
> 
> I prefer that for 4.3.

Done, I've proposed a patch as a reply to this e-mail. It's a one-liner.

> > However, relying on IRQ_NOAUTOEN being cleared doesn't seem like the
> > right long term solution, which is why I implemented what I believe is
> > a (hopefully) better long term solution.
> 
> Agreed.
> 
> I'll go over the proposed solution tomorrow afternoon (I'm
> traveling/conferencing...)

Sure, no problem.

I also noticed that MSI interrupts are not properly re-enabled after
resume, but it's not a regression from 4.2, as I can also reproduce the
issue on 4.2, so I'll handle that separately.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
