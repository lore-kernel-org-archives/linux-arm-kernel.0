From: rabin@rab.in (Rabin Vincent)
Date: Mon, 2 Apr 2012 01:02:36 +0530
Subject: [PATCH/RFC] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <CACRpkdb6+2SLm1Ojw2jNkK9ejW66fw2Pcit-b3AL67wP4Hr_ow@mail.gmail.com>
References: <1333294181-27653-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdb6+2SLm1Ojw2jNkK9ejW66fw2Pcit-b3AL67wP4Hr_ow@mail.gmail.com>
Message-ID: <CAH+eYFDqTrgpz7Rh+LyUUMBp+PuURgLzF5xv94jK7HkhDLRoHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 22:52, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Apr 1, 2012 at 5:29 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> The impact should be minimal since currently there are no mainline
>> systems which actually provide a vcore regulator so none need updating.
>
> Oh yes there are:
> drivers/mfd/db8500-prcmu.c
>
> This driver registers a number of voltage domain regulators,
> among those:
>
> static struct regulator_consumer_supply db8500_vape_consumers[] = {
> ? ? ? (...)
> ? ? ? ?REGULATOR_SUPPLY("vcore", "sdi0"),
> ? ? ? ?REGULATOR_SUPPLY("vcore", "sdi1"),
> ? ? ? ?REGULATOR_SUPPLY("vcore", "sdi2"),
> ? ? ? ?REGULATOR_SUPPLY("vcore", "sdi3"),
> ? ? ? ?REGULATOR_SUPPLY("vcore", "sdi4"),
> ? ? ? ?(...)
> ? ? ? ?REGULATOR_SUPPLY("vcore", "uart0"),
> ? ? ? ?REGULATOR_SUPPLY("vcore", "uart1"),
> ? ? ? ?REGULATOR_SUPPLY("vcore", "uart2"),
>
> IIRC the machine will not boot (i.e. these drivers cannot even
> probe) without these regulators in place, so they get enabled by
> the AMBA bus code.

These vcore "regulators" do nothing but increment a variable which is
write-only in mainline, so the machine will boot and drivers will probe
fine with Mark's patch.
