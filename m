From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 18:10:18 +0200
Subject: [PATCH 6/9] arm: mvebu: move cache and mvebu-mbus
 initialization later
In-Reply-To: <20130521154313.GV31290@titan.lakedaemon.net>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521141621.GU31290@titan.lakedaemon.net>
 <20130521173707.5a49eaec@skate>
 <20130521154313.GV31290@titan.lakedaemon.net>
Message-ID: <20130521181018.401ddabf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 21 May 2013 11:43:13 -0400, Jason Cooper wrote:

> > > I tried hacking it up to put it in mvebu/soc-internal_regs for a few
> > > rounds of testing in linux-next during review, however, I'd prefer you
> > > rebase this on top of mvebu/cleanup.
> > 
> > So you mean my next version of the "Internal registers switch" should
> > be based on mvebu/cleanup, right?
> 
> Yes, sorry I wasn't clear, I meant the series.  You can drop 1-3 as
> well for the next version, since I've pulled those.

Ok. 1-2 have been merged in mvebu/fixes, and 3 in mvebu/cleanup. So I
suppose mvebu/cleanup is based on mvebu/fixes ? Or should I base on
mvebu/cleanup and assume when it will lend in mainline, the mvebu/fixes
patches will be there (which doesn't make the thing easy for testing
here, because to test, I actually need all the patches in the same
branch). Just trying to figure the workflow :)

> > There will be some next version in any case, because I just found a
> > bug in the latest patch when booting from a bootloader that has
> > already done the switch to 0xF1.
> 
> Ok, I'll hold off putting it up for testing until v2.

Well, the current version should be ok build-wise, and works with all
currently available Marvell bootloaders. The bug can only be seen with
a bootloader version that has not yet been really released by Marvell.

But anyway, v2 will follow shortly. With this v1, I was mainly hoping
for some feedback, to see if the solution was acceptable or not.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
