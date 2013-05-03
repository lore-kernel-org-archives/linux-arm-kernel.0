From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 14:13:20 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <15723843.9mConxltov@wuerfel>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1367528578-518090-10-git-send-email-arnd@arndb.de>
 <CACRpkdY+5gdh1G7N+_Spg=iNZ0QMZ=ZXuhsVPuMEt62NxPhRxA@mail.gmail.com>
 <15723843.9mConxltov@wuerfel>
Message-ID: <CACRpkdYgGVepjaGY=1HP-GxE0mzTozA0aaT=jPe=aCPb5ppi9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 1:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 03 May 2013 10:14:28 Linus Walleij wrote:

>> While I understand that from a compile-time point of view it does
>> not seem nice, and all things would be separate units that you
>> plug in, from a run-time and system architecture point of view it
>> makes a lot of sense to select these. Worlds collide...
(...)
> My preference would be to make it user-selectable and enable it only in
> the defconfig, but if that can damage the hardware, we should not actually
> provide a named option.

Hm I'd lean towards the latter. However the AB8500 has subdrivers
and *some* of these are optional, such as the RTC. And it'd be
strange to have that depend on some totally unrelated config symbol
like UX500_SOC_COMMON.

I think that in that case we should make AB8500_CORE a hidden
(non-user selectable) bool so it is more logical.

However any if these approaches will lead to unaestetic menuconfig
with AB8500 suboptions appearing right in the MFD menu instead of
being ordered under a AB8500_CORE node which is better for
anyone actually trying to use menuconfig interactively.

The latter aestetic is one of the reasons why it looks as it does
IIRC, but maybe that is HTML thinking :-)

Yours,
Linus Walleij
