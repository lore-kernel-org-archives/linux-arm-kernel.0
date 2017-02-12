From: w@1wt.eu (Willy Tarreau)
Date: Sun, 12 Feb 2017 08:17:01 +0100
Subject: ARM: dts: rockchip: add the MiQi board's fan definition
In-Reply-To: <1552549.5mxCAWQDxc@phil>
References: <1486803415-14680-1-git-send-email-w@1wt.eu>
 <3614963.WjR2ddleWK@phil> <20170211174554.GA14513@1wt.eu>
 <1552549.5mxCAWQDxc@phil>
Message-ID: <20170212071701.GA18263@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2017 at 02:41:35AM +0100, Heiko Stuebner wrote:
> > I find it sad to waste all the performance
> > of a 3288 that way, otherwise it's easier to use something like a dirt
> > a much slower and cheaper cortex A5. But I agree with the point regarding
> > the gpio-pwm.
> 
> Even with the gpio-fan you should see results if you simply add the fan as 
> active trip point somewhere before the cpufreq trip points. So let the fan get 
> activated at 50/60? or so.

Better not do it as-is, the small fan is extremely noisy. That was the
benefit of the heartbeat mode, it was a poor man's pwm. I'll see what I
can do with the gpio-pwm. BTW, on all my MiQi, I have raised the critical
points to 90 degrees, one of my workplace build farm made of 4 MiQi, I
have connected a large slow fan which start to run above 85 degrees and
it's enough to prevent the critical point from ever being reached. The
dissipate heat is very low and the heatsink small so with minimal air
flow, the temperature drops very quickly.

Thanks,
Willy
