From: daniel@caiaq.de (Daniel Mack)
Date: Sun, 1 Nov 2009 22:16:26 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091101211325.GC2085@ucw.cz>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101211325.GC2085@ucw.cz>
Message-ID: <20091101211626.GV14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 01, 2009 at 10:13:25PM +0100, Pavel Machek wrote:
> > Is anyone using suspend/resume with a recent git mainline kernel on PXA
> > or other ARM embedded boards? My platform used to suspend and resume
> > just fine on 2.6.31 but now as I rebased it, it fails the resume part.
> 
> 2.6.32-rc* broke resume on spitz (pxa). I narrowed it down to crash in
> arch_suspend_enable_irqs() in kernel/power/suspend.c...
> 
> Can you try to light a led or something just before it to see if you
> hit same problem?

The problem seems more related to how the IRQs are set up, as I wrote in
my follow-up. Does reverting d2c370684 fix the problem for you, too?

Daniel
