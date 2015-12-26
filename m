From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Sat, 26 Dec 2015 22:38:05 +0100
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <87si2uux2s.fsf@eliezer.anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <20151218100826.GB1145@omega> <20151220221158.GA6416@omega>
 <874mfbflj3.fsf@eliezer.anholt.net> <20151222142643.GB29335@omega>
 <87si2uux2s.fsf@eliezer.anholt.net>
Message-ID: <567F08BD.50204@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 22.12.2015 20:01, skrev Eric Anholt:

>
>> After finally booting the RPi2 I get several messages of:
>>
>> unexpected IRQ trap at vector 00
>>
>> while typing _one_ character over uart.
> We were doing some debugging of that recently.  It seems that every once
> in a while we get woken up but nothing shows up in the top-level status
> register.  We need to just make the irqchip ignore instead of trying to
> look up a handler in that case, but I haven't prioritized it because it
> makes me worry that I'm just papering over a problem in our IRQ masking
> or something.
>
> I haven't seen any problems other than the printk, though.

Downstream has this patch[1]:
irq-bcm2836: Prevent spurious interrupts, and trap them early

It has been used in the nightly build of OpenELEC[2] for 5 days now without
any complaints (used with the downstream ARCH_BCM2709).

[1] 
https://github.com/raspberrypi/linux/commit/688a5f2ada4fbd16547b574a17e6d359ab2364d0
[2] http://forum.kodi.tv/showthread.php?tid=250817&pid=2192054#pid2192054
