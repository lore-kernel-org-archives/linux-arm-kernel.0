From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:47:26 +0100
Subject: [PATCH 06/11] ARM: mvebu: add Armada 380/385 support to the
 system-controller driver
In-Reply-To: <20140210173957.GS8533@titan.lakedaemon.net>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210173957.GS8533@titan.lakedaemon.net>
Message-ID: <20140210184726.2a787050@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 10 Feb 2014 12:39:57 -0500, Jason Cooper wrote:

> > Note that we intentionally do not use the same compatible string as
> > Armada 370/XP, as the current system-controller driver is far from
> > exploiting all the possibilities of the hardware, and we may in the
> > future discover differences between Armada 370/XP and Armada 380/385.
> 
> I'd much prefer to add a new compatible string iff it accompanies
> incompatible changes.
> 
> For now, I think it's best to use 'marvell,armada-370-xp-system-controller'
> in the dtsi file and change it when you introduce the incompatible
> features.

This doesn't work really well: if an user keeps an old DTB around,
which uses the old compatible string, then you're screwed because
there's no way a new kernel version can make the distinction between
Armada 370/XP and Armada 380/385. If we discover than Armada 380/385
need a special quirk to really work reliably for example, but that this
quirk doesn't apply to Armada 370/XP, then you have a serious problem.

Therefore, I would like to really insist to have separate compatible
strings for different SOCs. As an example, we used to have the same
compatible string for the timer between Armada 370 and Armada XP, and
later discovered that it was not possible due to a bug affecting only
one of the two SOCs. Our experience clearly shows that sharing
compatible strings is a bad idea, and having separate compatible
strings from the beginning doesn't cost anything, and offers higher
flexibility for the future.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
