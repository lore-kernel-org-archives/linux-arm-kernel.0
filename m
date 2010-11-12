From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 12 Nov 2010 13:39:50 +0100
Subject: [PATCH] [ARM] twd: Allow twd rescaling to match cpu frequency
In-Reply-To: <1283396674-4865-1-git-send-email-ccross@android.com>
References: <1283396674-4865-1-git-send-email-ccross@android.com>
Message-ID: <AANLkTinsRCinLdhq1xj0tx09Jb=Tohdbd7PUD=ae1q3m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

2010/9/2 Colin Cross <ccross@android.com>:

> The clock to the ARM TWD local timer scales with the cpu
> frequency. ?To allow the cpu frequency to change while
> maintaining a constant TWD frequency, pick a lower target
> frequency for the TWD and use the prescaler to divide down
> to the closest lower frequency.
>
> This patch provides a new initialization function that takes
> a target TWD frequency and the relation between the cpu
> clock and the TWD clock, required to be an integer divider
>>= 2 by the ARM spec. ?It also provides a function to be
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
