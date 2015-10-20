From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 20 Oct 2015 14:07:34 +0000
Subject: [PATCH 5/5] irqchip: armada-370-xp: document the overall driver
 logic
In-Reply-To: <20151020160021.374725f3@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020160021.374725f3@free-electrons.com>
Message-ID: <20151020140734.GF3953@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 04:00:21PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 20 Oct 2015 15:23:55 +0200, Thomas Petazzoni wrote:
> 
> > +/*
> > + * Overall diagram of the Armada XP interrupt controller:
> > + *
> > + *    To CPU 0                 To CPU 1
> > + *
> > + *       /\                       /\
> > + *       ||                       ||
> > + * +---------------+        +---------------+
> > + * |               |	 |               |
> 
> Things are a bit off here.
> 
> > + * |    per-CPU    |	 |    per-CPU    |
> > + * |  mask/unmask  |	 |  mask/unmask  |
> > + * |     CPU0      |	 |     CPU1      |
> > + * |               |	 |               |
> > + * +---------------+	 +---------------+
> > + *        /\                       /\
> 
> and here. So I can fix that up in the next version.
> 
> If we're doing ASCII art, let's do it properly.

Agreed.  It's not pressing.  You can resubmit these last two separately
and we'll cue them up for 4.4.

thx,

Jason.
