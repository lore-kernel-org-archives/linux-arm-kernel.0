From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Nov 2014 09:56:23 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Clock Fixes for v3.18
In-Reply-To: <201411192220.20365.arnd@arndb.de>
References: <cover.1415757100.git.horms+renesas@verge.net.au>
 <201411192220.20365.arnd@arndb.de>
Message-ID: <CAMuHMdXf2ndhmnx1c2jXp_QOrgibJPFvwVoxqndn=GFw=HV2aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Nov 19, 2014 at 10:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 13 November 2014, Simon Horman wrote:
>> Please consider these Renesas ARM based SoC clock fixes for v3.18.
>> Or alternatively for v3.19 if you feel they are too late for v3.18.
>
> I've merged all three 'fixes' pull requests you had into the fixes
> branch:
>
> Renesas ARM Based SoC Clock Fixes for v3.18
> Renesas ARM Based SoC DT Fixes for v3.18
> Renesas ARM Based SoC Fixes for v3.18
>
> I'm still waiting for a reply from Olof, since he seems to have
> skipped them last week when he sent the fixes pull request to Linus.
> If he had already decided to postpone the branches for 3.19, I'll
> just undo the merge here and put it into next/fixes-non-critical
> instead, I'm fine with it either way.

I agree the first two are non-critical.

The third, "Renesas ARM Based SoC Fixes for v3.18" may fix a regression
introduced in v3.16. While the original problem with the i2c timings was
indeed present in v2.6.37, the i2c bys most probably "just worked" (albeit with
wrong timings), until the i2c-sh_mobile driver got more picky in commit
7663ebefca8079ef ("i2c: sh_mobile: check timing parameters for valid range").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
