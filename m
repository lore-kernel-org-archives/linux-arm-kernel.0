From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Jul 2017 08:40:55 +0200
Subject: [PATCH 00/58] ARM: at91: rework Atmel TCB drivers
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170706064055.GE16144@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 11:50:41PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> This series reworks the Atmel Timer counter Block drivers. Those blocks
> each have 3 counters with 2 channels each and can be used for
> multiple functions:
>  - timers
>  - PWMs
>  - Quadrature decoders
>  - Stepper motor counters
> 
> Up until now, each TCB was fully used by each driver, possibly wasting
> counters/channels.
> 
> There is a second issue motivating that rework. Until now, the PIT is
> still used to boot then later in the boot sequence, the clocksource is
> switched to the TCB. This ends up not working well with preempt-rt
> because on some SoCs, the PIT interrupt is shared with the DBGU uart.
> When using preempt-rt the interrupt flags for the PIT and the DBGU end
> up being incompatible.
> 
> The rework breaks the DT ABI. Backward compatibility can be kept by
> keeping tcb_clksrc and atmel_tclib but as AVR32 is now gone from the
> kernel, I don't think it makes much sense to keep them.
> 
> Also, there is no other choice than breaking the mainly unused
> pwm-atmel-tcb binding. Only the kizbox is actually using it.
> 
> I think the bindings are now ok and I hope we can take the DT changes
> for 4.13.

Has anyone volunteered to pick this up? What are the dependencies here
and how did you plan to get this merged?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/813edc1e/attachment.sig>
