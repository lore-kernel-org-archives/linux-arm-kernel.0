From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 Dec 2014 10:39:59 +0100
Subject: [PATCH 0/4] ARM: shmobile: R-Mobile: Add SYSC restart handler
In-Reply-To: <20141204073409.GG25806@verge.net.au>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
 <20141204073409.GG25806@verge.net.au>
Message-ID: <CAMuHMdWFkz+kZanH47dzAVPnoB_RuTt=KLp72ziohMnZad5ErA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Dec 4, 2014 at 8:34 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Dec 03, 2014 at 03:17:03PM +0100, Geert Uytterhoeven wrote:
>> This patch series extends the PM domain platform driver for the R-Mobile
>> System Controller (SYSC) to register a restart handler, and removes the
>> restart handler hacks on DT-based R-Mobile A1 (r8a7740) and SH-Mobile AG5
>> (sh73a0) platforms.
>>
>> Note that this supports DT-based platforms only. Legacy platforms keep
>> on using the restart callback in struct machine_desc.
>>
>> This was tested on r8a7740/armadillo-multiplatform,
>> sh73a0/kzm9g-reference, and sh73a0/kzm9g-multiplatform.
>>
>> Arnd: is this what you had in mind in your response to "[GIT PULL] Third
>> Round of Renesas ARM Based Soc Updates for v3.19"
>> (http://www.spinics.net/lists/arm-kernel/msg379348.html)?
>>
>> Dependencies:
>>   - The first two patches depend on the series "[PATCH v6 0/7] ARM:
>>     shmobile: R-Mobile: DT PM domain support", as that series adds the
>>     SYSC PM domain platform driver for DT-based platforms and adds the
>>     SYSC device node to r8a7740.dtsi,
>
> As I have queued up that series I believe I could also queue up
> the first two patches of this series. Is that worthwhile?

Yes you can, if Arnd doesn't object against the driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
