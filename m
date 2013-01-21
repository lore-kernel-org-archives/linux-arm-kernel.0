From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 22:44:49 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <50FDBEAC.2050606@linaro.org>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
 <20130121211218.GX23505@n2100.arm.linux.org.uk> <50FDBEAC.2050606@linaro.org>
Message-ID: <20130121224449.GZ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 02:18:20PM -0800, John Stultz wrote:
> So we used to have the ACTHZ code to handle error from the HZ rate  
> requested and the HZ rate possible given the underlying hardware. That's  
> been moved to the register_refined_jiffies(), but do you have a sense if  
> there a reason it couldn't be used? I don't quite recall the bounds at  
> this second, so ~7% error might very well be too large.
>
> So yes, I suspect these sorts of platforms, where there are no modern  
> clocksource/clockevent driver, as well as further constraints (like  
> specific HZ) are likely not good candidates for a multi-arch build.

In this particular case, EBSA110 is not a candidate for multi-arch
build anyway, because it's ARMv4 and we're only really bothering with
ARMv6 and better.

Not only that, but the IO stuff on it is sufficiently obscure and
non-standard...
