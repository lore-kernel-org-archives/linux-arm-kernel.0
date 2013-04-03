From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Apr 2013 10:02:41 +0000
Subject: [GIT PULL] at91: soc for 3.10 #2
In-Reply-To: <515BD8C8.5060701@atmel.com>
References: <5152B357.3020500@atmel.com>
 <CAOesGMiy7q-xbc0SN78d7cvZmLgywy1PH7_Srw_=pzErSkrt-g@mail.gmail.com>
 <515BD8C8.5060701@atmel.com>
Message-ID: <201304031002.41770.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 April 2013, Nicolas Ferre wrote:
> > Also, USE_OF isn't set at that point (it's controlled by the next
> > section), so it can't be used as a replacement.
> > 
> > Also, isn't it a bit backwards in the first place to first set ATAGS
> > vs no-ATAGS, and then get to choose what hardware you want to build
> > for?
> 
> True, I was thinking it was a common pattern.

It's not common yet, but I want to get to the point where we can
globally disable ATAGS support for multiplatform kernels and get
only DT-enabled ones. There is no easy rule for when to select
or depend on a global feature, but there are a number of cases where
I think 'depends on' makes more sense in the long run.

Another example is CPU architecture level. Traditionally every
board selects CPU_v6 or CPU_v7, but in ARCH_MULTIPLATFORM, I created
a filter that lets you enable only one of them, and then pick all
the platforms that have the respective CPU, which is much easier
than having to know which platforms might be ARMv6 if you want to
build e.g. a kernel with THUMB2 support but as many boards enabled
as possible.

	Arnd
