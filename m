From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 2 Apr 2015 18:35:33 +0200
Subject: [PATCH 2/6] clocksource: add lpc32xx timer driver
In-Reply-To: <4915355.ihr3xRKEKp@wuerfel>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
 <1427923243-26296-3-git-send-email-manabian@gmail.com>
 <4915355.ihr3xRKEKp@wuerfel>
Message-ID: <CAGhQ9Vxpwb6M0vLerV8_xEDD_bz5ngN68u_2RgaR+LHz+Z2rqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 April 2015 at 16:24, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 01 April 2015 23:20:39 Joachim Eastwood wrote:
>> Add support for using the NXP LPC timer as clocksource and
>> clock event. These timers are present on many NXP devices
>> including LPC32xx, LPC17xx, LPC18xx and LPC43xx.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>
>
> Would it make sense to change mach-lpc32xx as a follow-up to use
> the same driver? It currently hardcodes a driver instead of using
> DT.

I believe it would be hard since mach-lpc32xx currently lacks a proper
clk driver. mach-lpc32xx/timer.c currently does a lot of SoC specific
init.

But if a better clk driver comes along for mach-lpc32xx the swap should be easy.

regards,
Joachim Eastwood
