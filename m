From: davidb@codeaurora.org (David Brown)
Date: Wed, 4 Jan 2012 17:17:04 -0800
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <4F048EC4.40900@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk>
 <4F048EC4.40900@arm.com>
Message-ID: <20120105011704.GA8870@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 05:39:16PM +0000, Marc Zyngier wrote:
> On 22/12/11 19:32, Russell King - ARM Linux wrote:
> 
> Hi Russell,
> 
> > On Thu, Dec 22, 2011 at 05:27:30PM +0000, Marc Zyngier wrote:
> >> The proposal is to convert local timer drivers to be "standalone" (not
> >> relying on the local timer infrastructure) and to use a CPU notifier
> >> to have the timer brought up or down on non-boot CPUs.
> > 
> > You do realise that it's pointless having local timers on non-SMP hardware.
> > On such hardware, you have a single timer instead.
> 
> I do. But on some non-SMP platforms, the local timer and the global
> timer can actually be the same (MSM is one example of this, and the UP
> version of the Cortex A15 is another).

On SMP MSM, we use the CPU0 local timer as the global timer.  They are
the same on non-SMP as well, I guess, but as Russell says, I'm not
sure what the concept of a local timer would mean on non-SMP.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
