From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 03 Dec 2014 21:16:27 +0100
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr> (Nicolas Pitre's
 message of "Wed, 3 Dec 2014 14:43:06 -0500 (EST)")
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
Message-ID: <87zjb4zdyc.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nicolas.pitre@linaro.org> writes:

> Let ktime_divns() use do_div() inline whenever the divisor is constant
> and small enough.  This will make things like ktime_to_us() and 
> ktime_to_ms() much faster.

Hi Nicolas,

I suppose the "small enough" is linked to the "!(div >> 32)" in your patch.  Can
I have the rationale which brought up this value, and if that value is universal
across architectures (ie. x86/ppc/arm/...) ?

And when you say "much faster", do you have figures to add to your commit
message ?

Cheers.

--
Robert
