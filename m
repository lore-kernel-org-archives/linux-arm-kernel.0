From: scaudle@codeaurora.org (Stephen Caudle)
Date: Wed, 01 Dec 2010 11:36:10 -0500
Subject: [PATCH v2] [ARM] gic: Unmask private interrupts on all cores
	during IRQ enable
In-Reply-To: <20101130180718.GB8521@n2100.arm.linux.org.uk>
References: <1288820762-16077-1-git-send-email-scaudle@codeaurora.org>
	<20101130180718.GB8521@n2100.arm.linux.org.uk>
Message-ID: <4CF6797A.2010807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2010 01:07 PM, Russell King - ARM Linux wrote:
> Sorry, missed this.
>
> If it's a private peripheral, it can only be accessed from its associated
> CPU.  What that means is you don't want to enable the interrupt on other
> CPUs as the peripheral may not be present or initialized on that CPU.

Understood.  But the alternative is to require all code that requests a 
PPI to have to enable the IRQ on the other cores.  This seems 
unreasonable to me.

> So I'm nervous about this change - architecturally it feels like the
> wrong thing to do to take the PPI interrupts through the generic IRQ
> infrastructure.

What do suggest as an alternative to this solution?  Creating separate 
IRQ numbers for each core (per PPI) doesn't seem to scale well as the 
number of cores increase.

~Stephen

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
