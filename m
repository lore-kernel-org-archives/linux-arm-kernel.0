From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 22:49:07 +0100
Subject: [PATCH] branch tracer: fix freak link error
In-Reply-To: <alpine.LFD.2.20.1602121639340.13632@knanqh.ubzr>
References: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602121639340.13632@knanqh.ubzr>
Message-ID: <3016048.Uym15Ei2Bs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 February 2016 16:45:03 Nicolas Pitre wrote:
> 
> It is certainly a worthwhile workaround if it solves all the known 
> cases.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> This trick doesn't work with the test case I produced to demonstrate 
> this bug though.  So we might be affected again in the future, or maybe 
> not if we're lucky.

Yes, I think it's clear that there is still something interesting going
on with the compiler and nested __builtin_compatible_p().

I'm currently creating a couple of gcc bug reports and plan to finally submit
this one as well.

Now I have to check if it does anything to the spurious "maybe-uninitialized"
warnings that I saw creeping in with PROFILE_ALL_BRANCHES. My guess is
that it doesn't fix them (I submitted a patch to turn off those
warnings today when PROFILE_ALL_BRANCHES is set), but I'll try anyway.

	Arnd
