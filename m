From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Oct 2015 16:08:28 +0200
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <20151020140427.GE3953@io.lakedaemon.net>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
Message-ID: <20151020160828.497fcc80@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Tue, 20 Oct 2015 14:04:27 +0000, Jason Cooper wrote:

> Whole series,
> 
> Reviewed by: Jason Cooper <jason@lakedaemon.net>

Thanks.

> Thomas (tglx), if you're happy with the core changes, let me know and
> I'll cue the series up.
> 
> We know it's a bit late in the -rc cycle, but the alternative (reverting
> Rob's patch) would likely be more destabilizing at this point.

As discussed on IRC, another simpler (code line wise) solution is to
simply clear the IRQ_NOAUTOEN flag in the irq-armada-370-xp, which
brings us back to what set_irq_flags() was doing, without actually
reverting Rob's patch.

However, relying on IRQ_NOAUTOEN being cleared doesn't seem like the
right long term solution, which is why I implemented what I believe is
a (hopefully) better long term solution.

But if you/tglx want something simple/stupid for 4.3 (one-line patch)
and then the real stuff for 4.4, I'd be happy to provide a series
implementing this idea.

Let me know what you and tglx think.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
