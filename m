From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Apr 2012 09:35:54 +0100
Subject: [PATCH] ARM: cache-l2x0.c: save aux ctrl for resume in case
 that l2x0 is enabled before init
In-Reply-To: <4F98D659.4030709@marvell.com>
References: <1335235280-25148-1-git-send-email-ylmao@marvell.com>
 <20120424082810.GA9367@arm.com> <4F98D659.4030709@marvell.com>
Message-ID: <20120426083554.GB18136@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 06:00:09AM +0100, Yilu Mao wrote:
> On 04/24/2012 04:28 PM, Catalin Marinas wrote:
> > On Tue, Apr 24, 2012 at 03:41:20AM +0100, Yilu Mao wrote:
> >> +	l2x0_saved_regs.aux_ctrl = aux;
> >> +
> >>   	aux&= aux_mask;
> >>   	aux |= aux_val;
> >
> > I think that's the wrong place to save it, it should be after the
> > masking was done.
> >
> > Anyway, if we cannot write this register in l2x0_init() because the L2
> > was enabled, do we expect the L2 to be disabled during resume?
> >
> Sorry, I don't think so.
> This is the right place to save it because we must make sure the saved 
> aux_ctrl is the same as what it is set.
> If we save it after masking was done, the saved value will be different 
> because we can't actually change the real setting.

And since we can't actually change the real setting on the resume path,
why do we need to save it anyway. Is your L2 cache disabled on the
resume path but not on the cold boot one?

-- 
Catalin
