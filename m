From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 16 Apr 2011 00:39:47 +0200 (CEST)
Subject: [RFC PATCH] genirq: implement read_irq_line for interrupt
 lines
In-Reply-To: <4DA8C1E2.3020205@codeaurora.org>
References: <1302892952-7090-1-git-send-email-adharmap@codeaurora.org>
	<alpine.LFD.2.00.1104152058050.2744@localhost6.localdomain6>
	<4DA8C1E2.3020205@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1104160030480.2744@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Apr 2011, Abhijeet Dharmapurikar wrote:

> Thomas Gleixner wrote:
> > On Fri, 15 Apr 2011, Abhijeet Dharmapurikar wrote:
> > 
> > > Some drivers need to know what the status of the interrupt line is.
> > > This is especially true for drivers that register a handler with
> > > IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING and in the handler they
> > > need to know which edge transition it was invoked for.
> > 
> > What's the purpose of this? How is that going to be used?
> 
> The main purpose is to know in the handler if it was invoked becuase of a
> rising edge or the falling edge.

Come on. That's not an explanation. I know that already and it does
not answer my question how this is going to be used. IOW: What does
the driver do aside of knowing that it was a rising falling edge?
 
> Now one could say that the driver should maintain some state and toggle it
> upon each invocation of this handler. That scheme quickly goes out of sync
> because we might ignore interrupts while suspended.

Suspend is a totaly different issue. I have the impression that you
are trying to solve some basic issue at the driver level again - just
this time you add some core helper to get it solved.

Can you please show _AND_ explain the code which is going to use this?

Thanks,

	tglx
