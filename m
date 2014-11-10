From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Nov 2014 14:48:30 +0100
Subject: [GIT PULL] Integrator multiplatform migration for v3.19
In-Reply-To: <7467543.qEZBkbRV4B@wuerfel>
References: <CACRpkdafst1j2tp4-=BZMn_P688uUSjeAZEGt26WuD_d521sHQ@mail.gmail.com>
 <20141104063235.GG13562@quad.lixom.net>
 <20141106105246.GO4042@n2100.arm.linux.org.uk>
 <7467543.qEZBkbRV4B@wuerfel>
Message-ID: <CACRpkdYcBdJsHfNfgYnguo4eWn7QUjgz_w_Qbr2NoDRE9-YCDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 6, 2014 at 12:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 06 November 2014 10:52:47 Russell King - ARM Linux wrote:

>> Unfortunately, this totally screws multiplatform support - with this
>> merged, we now can enable all CPUs from ARM720T upwards into a single
>> kernel - and that is illegal.
(...)
> I think it would be best to replace all the lines like
>
>         bool "Support ARM926T processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB
>
> with
>
>         bool "Support ARM926T processor" if ARCH_MULTI_V5 || MACH_REALVIEW_EB
>
> and ignore whether ARCH_INTEGRATOR is set or not.

OK I have sent a v2 patch for this check it out.

Sorry for screwing up so badly, I've done quite a few allmodconfig builds now,
just a bit confused with the other noise in linux-next.

Yours,
Linus Walleij
