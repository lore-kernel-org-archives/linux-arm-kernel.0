From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 29 Jan 2015 20:42:12 +0100
Subject: [PATCH v2] RTC: PXA: Fix regression of interrupt before ioremap
In-Reply-To: <54CA1ECA.8050000@tul.cz> (Petr Cvek's message of "Thu, 29 Jan
 2015 12:51:38 +0100")
References: <54CA1ECA.8050000@tul.cz>
Message-ID: <87fvatnzl7.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Interrupts appear before register set of the PXA2xx RTC controller is ioremaped.
>
> This fixes regression from:
>   'commit a44802f8fb7e593adabc6ef53c8df45a1717fa9b ("drivers/rtc/rtc-pxa.c: fix alarm can't wake up system issue")'
>   'commit 2f6e5f9458646263d3d9ffadd5e11e3d8d15a7d0 ("drivers/rtc: remove IRQF_DISABLED")'
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

No sorry, I don't like this.
It's not your patch I don't like, it fixes a real problem, but what happens then
if :
 - kernel boots
 - a process opens /dev/rtc0

The real issue is with patch a44802f "drivers/rtc/rtc-pxa.c: fix alarm can't
wake up system issue". I'd rather have you revert a44802f, which makes no sense
to me ...

Leo if you want to comment on it, feel free, and tell me if you tried your patch
with the code in Documentation/rtc.txt ?

Cheers.

--
Robert
