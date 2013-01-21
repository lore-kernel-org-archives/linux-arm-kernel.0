From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Jan 2013 23:05:45 +0100
Subject: [PATCH 6/6] clocksource: update and move armada-370-xp-timer
 documentation to timer directory
In-Reply-To: <201301211822.54129.arnd@arndb.de>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-7-git-send-email-gregory.clement@free-electrons.com>
 <201301211822.54129.arnd@arndb.de>
Message-ID: <50FDBBB9.8090504@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 07:22 PM, Arnd Bergmann wrote:
> On Monday 21 January 2013, Gregory CLEMENT wrote:
>> +
>> +Required properties:
>> +- compatible: Should be "marvell,armada-370-xp-timer"
>> +- interrupts: Should contain the list of Global Timer interrupts and
>> +  then local timer interrupts
>> +- reg: Should contain location and length for timers register. First
>> +  pair for the Global Timer registers, second pair for the
>> +  local/private timers.
>> +- clocks: clock driving the timer hardware
>> +
>> +Optional properties:
>> +- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
>> +  Mhz fixed mode (available on Armada XP and not on Armada 370)
> 
> This works fine, but I would consider it slightly cleaner to kill
> the marvell,timer-25Mhz property and instead have separate 
> marvell,armada-370-timer and marvell,armada-xp-timer compatible
> strings, since the two timers are actually different, rather than wired
> differently.

Hum, I am not sure they are different. From my point of view it is the same IP,
but the one on Armada XP can use a 25MHz fix source clock. Apart from this,
all the registers are the same. Moreover currently with this property we still have
the possibility to not use the 25MHz clock source on Armada XP which is totally valid.
The use of this source clock is not mandatory for the Armada XP SoCs.

For now I prefer to keep this property.

Gregory
