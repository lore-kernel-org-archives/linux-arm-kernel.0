From: harald.gustafsson@ericsson.com (Harald Gustafsson)
Date: Fri, 12 Nov 2010 13:49:50 +0100
Subject: [PATCH] [ARM] twd: Allow twd rescaling to match cpu frequency
In-Reply-To: <AANLkTinsRCinLdhq1xj0tx09Jb=Tohdbd7PUD=ae1q3m@mail.gmail.com>
References: <1283396674-4865-1-git-send-email-ccross@android.com>,
	<AANLkTinsRCinLdhq1xj0tx09Jb=Tohdbd7PUD=ae1q3m@mail.gmail.com>
Message-ID: <DB5ED9F94071134F8D813944A461CF1A0196031CBA@ESESSCMS0361.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Don't forget the other patches to make this work:

[ARM] twd: Always calibrate local timer
[ARM] twd: Fix updating control register in set_mode
[ARM] twd: Fix prescaler getting cleared by set_mode

/Harald Gustafsson
________________________________________
From: Linus Walleij [linus.ml.walleij at gmail.com]
Sent: Friday, November 12, 2010 1:39 PM
To: Colin Cross
Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Russell King; srinidhi kasagar; Varun Swara; Catalin Marinas; Harald Gustafsson; Rickard ANDERSSON
Subject: Re: [PATCH] [ARM] twd: Allow twd rescaling to match cpu frequency

Hi Colin,

2010/9/2 Colin Cross <ccross@android.com>:

> The clock to the ARM TWD local timer scales with the cpu
> frequency.  To allow the cpu frequency to change while
> maintaining a constant TWD frequency, pick a lower target
> frequency for the TWD and use the prescaler to divide down
> to the closest lower frequency.
>
> This patch provides a new initialization function that takes
> a target TWD frequency and the relation between the cpu
> clock and the TWD clock, required to be an integer divider
>>= 2 by the ARM spec.  It also provides a function to be
> called from cpufreq drivers to set the prescaler whenever
> the cpu frequency changes.

What's the status of this patch?

We have basically the same problem so we'd really like
a generic solution to this problem.

Our only comment is that we cannot see the reason for
not using the CPUfreq notifiers as most scaling code
is, but I assume there is some specific reason for this?

Unless something holds this back, could you post it to
Russells patch tracker, we might have an add-on patch
for the U8500 later.

Yours,
Linus Walleij
