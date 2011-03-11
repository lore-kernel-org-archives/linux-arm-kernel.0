From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 11 Mar 2011 21:12:13 +0100 (CET)
Subject: [Qualcomm PM8921 MFD v2 2/6] mfd: pm8xxx: Add irq support
In-Reply-To: <20110311195719.GX1760@opensource.wolfsonmicro.com>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-3-git-send-email-adharmap@codeaurora.org>
	<alpine.LFD.2.00.1103081201520.2787@localhost6.localdomain6>
	<4D770E47.6050402@codeaurora.org>
	<alpine.LFD.2.00.1103101126100.2787@localhost6.localdomain6>
	<4D79A85D.8000301@codeaurora.org>
	<alpine.LFD.2.00.1103111853480.2787@localhost6.localdomain6>
	<4D7A71B9.9000306@codeaurora.org>
	<alpine.LFD.2.00.1103112020370.2787@localhost6.localdomain6>
	<20110311195719.GX1760@opensource.wolfsonmicro.com>
Message-ID: <alpine.LFD.2.00.1103112100240.2787@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Mar 2011, Mark Brown wrote:

> On Fri, Mar 11, 2011 at 08:43:08PM +0100, Thomas Gleixner wrote:
> 
> > Sigh, why insist people on working around core code instead of talking
> > to the responsible maintainers about their problem in the first place?
> 
> I don't know if it's the case here but with a lot of the people I speak
> to it's because they're used to working on proprietary OSs where there's
> no possibility of fixing the core and they haven't yet realised that
> this is a possibility.

Good point. If I only knew a way to get this message to those folks
once and forever.

There are several good reasons to avoid working around core code:

 - It's usually simpler and faster as the core code has all the
   necessary information. So that's even an argument which managers
   might understand.

 - Such workarounds, when not caught, tend to spread themself
   magically because driver writers checkout the existing code of
   similar devices and copy/paste/modify^Wuglify them over and over.

 - In the worst case such workarounds make the core maintainence
   harder and in some cases impossible, because they silently imply
   semantics on the core w/o the core maintainer knowing about them.

I'm going to give a talk about that at the collab summit :)

Thanks,

	tglx
