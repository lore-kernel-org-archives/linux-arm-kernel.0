From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Oct 2011 09:33:38 +0200
Subject: [PATCH 16/26] ARM: pxa: CPU_PJ4 requires IWMMXT
In-Reply-To: <CAMPhdO96WwmPVqVpM2Vpef3wSgfHEf-0tK5VewXn-EGMns2ubA@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<20295619.jOfPxmug8T@wuerfel>
	<CAMPhdO96WwmPVqVpM2Vpef3wSgfHEf-0tK5VewXn-EGMns2ubA@mail.gmail.com>
Message-ID: <201110040933.38389.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 October 2011, Eric Miao wrote:
> I think this is true for other xscale CPUs as well, so either we make
> them unconditionally all at once, or we still leave an option here.

Do all xscale have iwmmxt?

> It actually looks quite odd to me that CPU_PJ4 is made special here,
> what're the real broken builds errors?

Yes.

I should probably have provided a longer description of the problem.
The build error is in arch/arm/kernel/pj4-cp0.c, which calls
iwmmxt_task_release unconditionally. The code is obviously
copy-pasted from arch/arm/kernel/xscale-cp0.c, which does much
of the same, but uses both run-time and compile-time conditionals
for iwmmxt.

	Arnd
