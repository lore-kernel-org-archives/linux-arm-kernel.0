From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 15 Jul 2016 16:22:31 +0200
Subject: [linux-sunxi] Re: [PATCH v2 06/14] ARM: sun8i: clk: Add
 clk-factor rate application method
In-Reply-To: <98fd2ab2-9b1d-1494-5867-7701780fd471@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
 <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
 <20160715152756.db7375a7109fed18c2fbf43a@free.fr>
 <98fd2ab2-9b1d-1494-5867-7701780fd471@megous.com>
Message-ID: <CAOMqctTds7adsfvehfv8wcxbb0NOpEQE5wRff6NwfPOUa3SbRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 15 July 2016 at 15:48, Ond?ej Jirman <megous@megous.com> wrote:
>
>
> On 15.7.2016 15:27, Jean-Francois Moine wrote:
>> On Fri, 15 Jul 2016 12:38:54 +0200
>> Ond?ej Jirman <megous@megous.com> wrote:
>>
>>>> If so, then yes, trying to switch to the 24MHz oscillator before
>>>> applying the factors, and then switching back when the PLL is stable
>>>> would be a nice solution.
>>>>
>>>> I just checked, and all the SoCs we've had so far have that
>>>> possibility, so if it works, for now, I'd like to stick to that.
>>>
>>> It would need to be tested. U-boot does the change only once, while the
>>> kernel would be doing it all the time and between various frequencies
>>> and PLL settings. So the issues may show up with this solution too.
>>
>> I don't think this is a good idea: the CPU clock may be changed at any
>> time with the CPUFreq governor. I don't see the system moving from
>> 1008MHz to 24MHz and then to 1200MHz when some computation is needed!
>
> PLL lock time is around 10-20us, I'd guess based on the number of loops
> in the PLL lock wait loop. So unless you'll be switching frequencies
> many times per second, this should be barely noticeable.
>
> But I'd like a different solution too.

Do you have a patch to test this?

For me changing CPU frequency on Orange Pi One always locks up the
system. I keep running it on the u-boot setup 1.08GHz at 1.1V

Thanks

Michal
