From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 03 Jan 2014 07:05:14 +0100
Subject: [PATCH 2/2] sched_clock: Disable seqlock lockdep usage in
 sched_clock
In-Reply-To: <1388704274-5278-2-git-send-email-john.stultz@linaro.org> (John
 Stultz's message of "Thu, 2 Jan 2014 15:11:14 -0800")
References: <52C5E675.80701@linaro.org>
 <1388704274-5278-1-git-send-email-john.stultz@linaro.org>
 <1388704274-5278-2-git-send-email-john.stultz@linaro.org>
Message-ID: <m3fvp5txb9.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Stultz <john.stultz@linaro.org> writes:

> Unforunately the seqlock lockdep enablmenet can't be used
> in sched_clock, since the lockdep infrastructure eventually
> calls into sched_clock, which causes a deadlock.
>
> Thus, this patch changes all generic sched_clock usage
> to use the raw_* methods.

These two patches fix the problem. Thanks to all involved.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
