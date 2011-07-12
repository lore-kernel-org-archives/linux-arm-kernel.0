From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jul 2011 11:19:48 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <20110712101252.GA9604@e102568-lin.cambridge.arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
	<20110711184010.GB8486@n2100.arm.linux.org.uk>
	<20110712101252.GA9604@e102568-lin.cambridge.arm.com>
Message-ID: <20110712101948.GD23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 11:12:57AM +0100, Lorenzo Pieralisi wrote:
> Thank you very much Russell for this recap.
> 
> On Mon, Jul 11, 2011 at 07:40:10PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 11, 2011 at 03:00:47PM +0100, Lorenzo Pieralisi wrote:
> > > Well, short answer is no. On SMP we do need to save CPU registers 
> > > but if just one single cpu is shutdown L2 is still on. 
> > > cpu_suspend saves regs on the stack that has to be cleaned from
> > > L2 before shutting a CPU down which make things more complicated than
> > > they should.
> > 
> > Hang on.  Please explain something to me here.  You've mentioned a few
> > times that cpu_suspend() can't be used because of the L2 cache.  Why
> > is this the case?
> > 
> > OMAP appears to have code in its sleep path - which has been converted
> > to cpu_suspend() support - to deal with the L2 issues.
> > 
> 
> OMAP4, it is SMP configs I am talking about.

Seriously, that's not something which really concerns me at present
because suspend/resume in any form is not supported there in any form
in mainline.

All my comments are based on the mainline kernel.  That's what I work
with.  Everything elsewhere is not my concern.

So, let me say again.  OMAP suspend/resume support _in_ _mainline_ will
be converted at the next merge window.  As that's only OMAP3 _in_
_mainline_ which has the need for saving state etc, that's the only
OMAP code I have access to, and therefore that's the only thing which
I've been able to fix.

OMAP4 suspend/resume support doesn't exist in mainline and therefore
doesn't exist for me.
