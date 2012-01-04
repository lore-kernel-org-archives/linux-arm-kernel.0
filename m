From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 04 Jan 2012 17:39:16 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <20111222193216.GO2577@n2100.arm.linux.org.uk>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk>
Message-ID: <4F048EC4.40900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/11 19:32, Russell King - ARM Linux wrote:

Hi Russell,

> On Thu, Dec 22, 2011 at 05:27:30PM +0000, Marc Zyngier wrote:
>> The proposal is to convert local timer drivers to be "standalone" (not
>> relying on the local timer infrastructure) and to use a CPU notifier
>> to have the timer brought up or down on non-boot CPUs.
> 
> You do realise that it's pointless having local timers on non-SMP hardware.
> On such hardware, you have a single timer instead.

I do. But on some non-SMP platforms, the local timer and the global
timer can actually be the same (MSM is one example of this, and the UP
version of the Cortex A15 is another).

> You're also aware I assume that local timers are different from the global
> timer itself, and require to have additional callbacks for broadcasting
> the global timer tick?

I was under the impression that we either have the global timer together
with broadcasting or the local timers. Completely removing the broadcast
callback doesn't seem to generate any ill effect as long as the local
timers are used instead of the global timer (which of course requires
broadcast in the SMP configuration).

	M.
-- 
Jazz is not dead. It just smells funny...
