From: dt.tangr@gmail.com (Daniel Tang)
Date: Wed, 29 May 2013 15:14:41 +1000
Subject: [RFC PATCHv4 1/6] arm: TI-Nspire platform code
In-Reply-To: <201305271715.02385.arnd@arndb.de>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305270856.19456.arnd@arndb.de>
 <CAPnH9dnA22C3ZS9jgJNytnmKM_8Vfk7OxNRB1Mg03=q7KhHZBA@mail.gmail.com>
 <201305271715.02385.arnd@arndb.de>
Message-ID: <10704A21-6BEC-42DC-BB1E-88A0E87D288B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/05/2013, at 1:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 27 May 2013, Daniel Tang wrote:
>> Before any peripheral is accessed. I.e. before the clocksource and irqchip
>> drivers.
> 
> The irqchip comes first, and by that time, you can actually call
> of_iomap().
> 
>> The write to the port is supposed to ensure all mmio peripherals can be
>> accessed. Without it, access to certain peripherals will result in
>> undefined reads or ignored writes.
>> 
>> On second thoughts, would this actually be the job of the boot loader?
> 
> Doing it in the boot loader would certainly simplify things. I wonder
> about the dynamic aspects of power management though: It might be
> better to expose the individual bits of this register through a proper
> driver. The boot loader can start out enabling everything, but then
> you turn off everything that is not needed when that driver gets
> loaded.

That's the idea for the long term.

For now though, I'll probably just let the bootloader enable everything and work on a proper driver for power management later.

> 
> I'm still not sure what the register actually does: Does it
> control reset lines, clock signals, voltage regulators or something
> else? These things all have their own subsystems, and then there
> is also the power domain framework.

To be perfectly honest, I'm not too sure. The documentation for the TI-Nspire is all gathered from reverse engineering and all it says is that register "disables bus access to peripherals".

> 
> 	Arnd

Cheers,
Daniel Tang
