From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Feb 2014 22:24:34 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87ppmk2lbs.fsf@natisbad.org>
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140218141031.255bd1ba@skate> <87ppmk2lbs.fsf@natisbad.org>
Message-ID: <20140218222434.7e447b80@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Tue, 18 Feb 2014 21:54:31 +0100, Arnaud Ebalard wrote:

> > I finally got some idea: your kernel 3.13-rc7 lacks a very important
> > fix we did in the irqchip driver MSI handling. You really need to have
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/irqchip/irq-armada-370-xp.c?id=c7f7bd4a136e4b02dd2a66bf95aec545bd93e8db
> > applied to get proper MSI behavior. Without this patch, there is a race
> > condition, and some MSI interrupts might be lost.
> >
> > This commit was merged in v3.14-rc2, and backported to 3.13 and
> > previous stable releases.
> >
> > Can you test after applying this commit?
> 
> Just to be sure, I compiled a 3.13 w/ PCI_MSI enabled and w/o the fix:
> it failed as usual. Then, I just applied the fix on top of it and tested
> again: I was unable to make it fail, i.e. this oneline fixes the issue.

Cool!

> Sarah, I guess this also validates the fact that FL1009 has good MSI
> support ;-)
> 
> Thanks for the time you both spent. Let's close the case.

You're welcome. Sorry for having realized so late from where the
problem could be coming from, and that it was in fact already fixed.

Thanks to you for reporting and investigating the issue in the first
place!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
