From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 23 May 2016 15:59:12 +0200
Subject: [PATCH] misc: atmel-secumod: Driver for Atmel "security module".
In-Reply-To: <20160523145315.38eacf07@bbrezillon>
References: <1453348655-31182-1-git-send-email-davidm@egauge.net>
 <20160125110921.GA4027@piout.net>
 <CALnQHM13cGnoma_3erb0oCnRD0sYGGNF1E1cgzCJHrEXbvJpRQ@mail.gmail.com>
 <alpine.LNX.2.00.1601291055520.23683@nippy.intranet>
 <20160131113409.GI20165@piout.net>
 <20160523140424.7ded3893@bbrezillon>
 <20160523145315.38eacf07@bbrezillon>
Message-ID: <20160523135912.GA2580@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/2016 at 14:53:15 +0200, Boris Brezillon wrote :
> > Well, I think we're reaching this point right now: I have to implement
> > "freeze" mode (entering a deep sleep mode by cutting all power domains
> > except VDDBU), and in order to do that I need to access BUREGs which
> > are part of the secu-sram you're trying to expose here.
> > 
> > Two comments on the nvmem approach:
> > 1/ first of all it's not really a non-volative memory: if you loose
> > VDDBU you also loose the whole SRAM content.
> > 2/ I need to be able to reserve the BUREG region (at least part of it)
> > for in kernel usage (need to store the SDRAM address I should jump to
> > when exiting freeze mode).
> 
> Forget this aspect. As Alexandre pointed out, the nvmem framework
> provides an in-kernel API, so reserving space for the "freeze" mode
> implementation is doable. But need to use the securam for advanced
> stuff (like executing code from there) then the SRAM driver approach is
> more future-proof IMO.
> 

Yeah, in case we want to use the SRAM to actually run some code, we will
need the sram driver.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
