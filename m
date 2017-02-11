From: w@1wt.eu (Willy Tarreau)
Date: Sat, 11 Feb 2017 18:45:54 +0100
Subject: ARM: dts: rockchip: add the MiQi board's fan definition
In-Reply-To: <3614963.WjR2ddleWK@phil>
References: <1486803415-14680-1-git-send-email-w@1wt.eu>
 <3614963.WjR2ddleWK@phil>
Message-ID: <20170211174554.GA14513@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Sat, Feb 11, 2017 at 05:33:16PM +0100, Heiko Stuebner wrote:
> Hi Willy,
> 
> Am Samstag, 11. Februar 2017, 09:56:55 CET schrieb Willy Tarreau:
> > The MiQi board is sold with an enclosure in which a fan is connected
> > to the second LED output, and configured by default in "heartbeat"
> > mode so that it rotates slowly and increases when the CPU load
> > increases, ensuring appropriate cooling by default. This LED output
> > is called "Fan" in the original kernel and connected to GPIO18
> > (gpiochip 0, pin 18). Here we called it "miqi:green:fan" to stay
> > consistent with the kernel's naming conventions.
> 
> I tend to disagree with this approach. A fan is not a led and the devicetree 
> is about describing the hardware, not how a specific kernel likes to use things 
> :-) .

Sure but I was trying to stay as close as possible to the intended
purpose of the connector on the board as it is sold :-)

> The kernel already has a gpio-fan driver (drivers/hwmon) or you could 
> resurrect the gpio-pwm patch [0] from Olliver Schinagl and use the pwm-fan on 
> top of that for more intermediate steps.

Ah it's great to know there has already been something like this because
I thought about developing one for the same reason.

> > It's worth noting that without this patch the fan doesn't work at
> > all, risking to make the board overheat.
> 
> At least cpufreq is already hooked to the thermal controller on the rk3288, so 
> even without additional cooling it should select lower cpu frequencies keeping 
> the heat in line and prevent overheating the board.

Well that's one way to see it, as for me throttling the CPU is the last
resort before seeing it die ; I find it sad to waste all the performance
of a 3288 that way, otherwise it's easier to use something like a dirt
a much slower and cheaper cortex A5. But I agree with the point regarding
the gpio-pwm. I think that mqmaker initially designed the GPIO to be used
as a led to benefit from the heartbeat trigger which more or less replaces
what a more efficient thermal control could achieve.

Thanks!
Willy
