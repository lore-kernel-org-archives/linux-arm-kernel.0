From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Dec 2017 11:11:31 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <1513153607.2439.2.camel@Nokia-N900>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
Message-ID: <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 9:26 AM, Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Wed Dec 13 08:34:22 2017 Linus Walleij <linus.walleij@linaro.org> wrote:
>> Arnd has been nudging me to do DT conversion for EP93xx
>> so if there are many active industrial users of these
>> I should prioritize it, because these things have 20+ years
>> support cycles.
>
> I'm not sure how important or necessary at all is to change anything in these legacy platforms.

I suspect that at several points in the next 5 to 10 years, we will remove
additional platforms or CPU types, as we tend to do when a platform
becomes a maintenance burden and is clearly not used by anyone.

It's hard to predict in advance what triggers the removal, but as the
number of platforms that are not using DT or ARCH_MULTIPLATFORM
goes down to a small number, there will be increased interested in either
removing or converting the remaining ones. This is not an immediate
danger at the moment, since we still have 14 platforms that are not
using ARCH_MULTIPLATFORM, and 23 that have remaining
board files, but you don't want to be the last user of the last platform
after the other ones are done ;-)

>> We also need to think about upholding support in GCC for
>> ARMv4(t) for the foreseeable future if there is a big web of
>> random deeply embedded systems out there that will need
>> updates.
>
> But we should definitely preserve at least what we have.

Plain ARMv4 (and earlier) support in gcc is already marked 'deprecated'
and will likely be gone in gcc-8 (it's still there as of last week). ARMv4T
is going to be around for a while, and you can even keep building for
ARMv4 using "-march=armv4t -marm" when linking with 'ld --fix-v4bx'.

Debian recently did a survey to find out whether there were still users
on ARMv4 or ARMv4T, and the result was that probably everyone is
on ARMv5E or ARMv6 for the ARM port (which is separate from the
ARMHF port that is ARMv7+). See also
https://lists.debian.org/debian-user/2017/11/msg00379.html
and let them know quickly if you use Debian stable releases and
plan to update to Debian 10 (Buster) in the future.

     Arnd
