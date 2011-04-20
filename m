From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 08:36:55 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110419162742.GB24372@redhat.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191655.13133.arnd@arndb.de>
	<BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
	<201104191801.19348.arnd@arndb.de>
	<20110419162742.GB24372@redhat.com>
Message-ID: <BANLkTikYMFjjO+igBLN+FoXtWC_uroVUPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/19 Dave Jones <davej@redhat.com>:

> The platform drivers are by their nature architecture specific,
> so arch/ seems apropos. ?drivers/platform/arm/ maybe ?

I opted for putting stuff in there, it was not popular, it will probably
just cause overpopulation there instead, like drivers/misc is doing
right now :-(

> Though, having arm do something different to every other arch seems
> a bit awkward too. Everyone else has their cpufreq platform driver
> somewhere under arch/whatever/../cpufreq/.. ?so changing that
> violates the principle of least surprise.
>
> I'm also not convinced that moving them would increase review of changes.
>
> What problem is this solving again ?

Recent complaints from Linus (the other one) about overpopulation
bad code reuse and patch collision churn in the arch/arm/* tree.

If all cpufreq drivers (including the x86 ones!) were under
drivers/cpufreq/* it would mean better review and more
opportunity for consolidation I guess? We could begin the move
with a few ARM architectures. Do you agree?

Yours,
Linus Walleij
