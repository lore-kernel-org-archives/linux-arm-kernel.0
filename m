From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 12 Jan 2012 18:38:01 -0600
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <20120112193639.GL1068@n2100.arm.linux.org.uk>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
 <20120111165508.GC1068@n2100.arm.linux.org.uk>
 <201201111827.18890.arnd.bergmann@linaro.org>
 <20120111194334.GF1068@n2100.arm.linux.org.uk>
 <4F0EF119.3000605@atmel.com>
 <20120112193639.GL1068@n2100.arm.linux.org.uk>
Message-ID: <CAMXH7KEX+pMZvSnb5HHuMFaPbupSx+qCJkGtoDLTDkaboHCoMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 1:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Okay, that makes sense (because everything but rm9200 branches out to
> one of the cpu idle functions.)
>
> It also supports my second idea described in
> http://lists.arm.linux.org.uk/lurker/message/20120109.144443.3626e5a6.en.html
> See the paragraph starting "So, what I suggest instead" at that URL and
> following text.
>
> The reason I think this is the best solution is:
> (a) we move the CPU dependencies into each CPU file
> (b) we localize the quirks needed for each CPU into its own specific code
> (c) we can select at run time between the various standby functions
>
> These are all AT91 specific wins. ?What it also gets us is _much_ less
> exported code from arch/arm/mach-at91 when the CPU idle stuff moves out,
> reducing it down to just a mere function pointer, and, because the AT91
> specific idle stuff is hidden behind this it potentially opens the door
> towards some consolidation in this area between different SoCs.

Apologies if this is a dumb question, but for the arch/arm/mach-at91
function pointer that needs to be exported, what is the recommended
method for exporting it to a file that needs it in drivers/cpuidle?
