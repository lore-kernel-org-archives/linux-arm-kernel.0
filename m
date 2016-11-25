From: tmshlvck@gmail.com (Tomas Hlavacek)
Date: Fri, 25 Nov 2016 13:49:11 +0100
Subject: [RFC PATCH] ARM: dts: Add support for Turris Omnia
In-Reply-To: <20161124150700.GD7155@lunn.ch>
References: <1479851991.26813.2@smtp.gmail.com>
 <1479859770-9375-1-git-send-email-tmshlvck@gmail.com>
 <20161123003505.GL2691@lunn.ch>
 <4e3f9628-dbf8-27c1-abea-d0ef58a67e51@kleine-koenig.org>
 <20161124150700.GD7155@lunn.ch>
Message-ID: <1480078151.381.4@smtp.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Nov 24, 2016 at 4:07 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>  @Tomas: I think it doesn't make sense when we alternate sending 
>> patches
>>  without prior arrangement. Do you already work on a v5? If not I 
>> can do
>>  that to fix the last few comments. Not sure when a submission is too
>>  late to enter v4.10, but I think the window isn't that big any more.
> 
> It is getting a bit late. But maybe Linus will add in another -rc
> week.
> 
>> 
>>  > No leds? No buttons via gpio-keys?
>> 
>>  The leds are controlled by a Cortex-M0 and without intervention 
>> blink
>>  according to a hardware function (network, power, pci). IMHO that's 
>> ok
>>  for an initial setup.
> 
> Yes. That is fine. It is just unusual. Most boards have gpio-led and
> gpio-keys, which are easy to add. That is why i asked. Adding an LED
> driver which talks to this M0 can be added later.

Actually the WiP driver for MCU LED interface, that we use in our 
kernel is here: 
https://github.com/tmshlvck/omnia-linux/commit/2121afd8fbd2e4c720edcdd472b11b5303bc0dfb

It definitely needs some cleanup and it adds non-standard features 
(main PWM for all LEDs, autonomous blink mode, colors) via custom /sys 
files, which I suspect that is not going to be acceptable for upstream. 
Let's keep it for the next iteration.

Regarding the button, we actually have one, that is connected to the 
MCU and by default it sets LED brigtness autonomously, but it should be 
able to generate IRQs via the MCU if we change the mode in the MCU. 
I'll look into that.

Tomas
