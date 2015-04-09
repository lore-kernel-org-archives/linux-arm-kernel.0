From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 9 Apr 2015 22:43:55 +0200
Subject: [PATCH 2/6] clocksource: add lpc32xx timer driver
In-Reply-To: <2923915.RDtqXmzaM0@wuerfel>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
 <4915355.ihr3xRKEKp@wuerfel>
 <CAGhQ9Vxpwb6M0vLerV8_xEDD_bz5ngN68u_2RgaR+LHz+Z2rqA@mail.gmail.com>
 <2923915.RDtqXmzaM0@wuerfel>
Message-ID: <CAGhQ9Vw4Jr5fpnsmAWDiTioFOP53vkKEuA3h4H+_xn182P+=QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 April 2015 at 22:24, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 02 April 2015 18:35:33 Joachim Eastwood wrote:
>> On 2 April 2015 at 16:24, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 01 April 2015 23:20:39 Joachim Eastwood wrote:
>> >> Add support for using the NXP LPC timer as clocksource and
>> >> clock event. These timers are present on many NXP devices
>> >> including LPC32xx, LPC17xx, LPC18xx and LPC43xx.
>> >>
>> >> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> >>
>> >
>> > Would it make sense to change mach-lpc32xx as a follow-up to use
>> > the same driver? It currently hardcodes a driver instead of using
>> > DT.
>>
>> I believe it would be hard since mach-lpc32xx currently lacks a proper
>> clk driver. mach-lpc32xx/timer.c currently does a lot of SoC specific
>> init.
>>
>> But if a better clk driver comes along for mach-lpc32xx the swap should be easy.
>
> Right, makes sense.

I will be getting a LPC3250 board soon so I can take a look at the clk
stuff. But from what I can see the clk register layout (system control
block) on lpc32xx seems very hairy.

btw, I noticed that the lpc32xx timer really has two clk inputs. On
lpc18xx both are feed by the same clk, but not on lpc32xx. So I will
update the driver and DT bindings to reflect this in the next version.


best regards,
Joachim Eastwood
