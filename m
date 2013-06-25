From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Jun 2013 16:14:13 +0200
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <20130625135648.GA2327@linaro.org>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
 <20130607175007.GH8111@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306072214120.18597@syhkavp.arg>
 <20130621093311.GD6983@mudshark.cambridge.arm.com>
 <CAKv+Gu8FTXC9XSE4DJ2LQueJ3FKjdjv8=sjDjTETH7fq+ruNGQ@mail.gmail.com>
 <51C46A0D.8070505@codeaurora.org>
 <20130625135648.GA2327@linaro.org>
Message-ID: <CAKv+Gu8psQZhPHrzPVTniO+W4qPnc6jwMboz3VRdVC4ezxv4MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 June 2013 15:56, Dave Martin <dave.martin@linaro.org> wrote:
> Significant benchmarks on the boot path would be unacceptable, unless they
> are *fast* (and by fast, I mean fast on all platforms, not just fast on
> the fast platforms).  If one second gets added onto the boot path for each
> optimised algorithm, that sounds like a fail.  If all the benchmarks
> combined take one second in total, that's no quite as bad.
>
> Maybe benchmarks could be time-bounded (i.e., see how much data we can
> chug though in X milliseconds) instead of size-bounded.  This would avoid
> unreasonable slowdown on slow platforms, while avoiding trivially small
> benchmark payloads on faster platforms which may typically have a more
> complex architecture, bigger caches etc. which would cause them to take
> longer to reach saturated performance when running a particular algorithm.
>

Benchmarks are already time bounded, at least the instances I am aware
of (xor and raid6) are. They each measure, for each available
implementation, the amount of work performed during a fixed time. For
RAID6, this is 16 jiffies, for XOR it's only 1 jiffy but each test is
repeated 5 times.

So I think this should not be a problem, especially as it is unlikely
that newly added implementations (such as NEON) will be able to
execute on older/slower platforms in the first place.

Regards,
Ard.
