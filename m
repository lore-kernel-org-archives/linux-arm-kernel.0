From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 14 Jul 2013 10:34:42 +0200
Subject: [PATCH] ARM: multiplatform: remove reference to ARCH_MULTI_V4
In-Reply-To: <1373746191.1359.37.camel@x61.thuisdomein>
References: <1373746191.1359.37.camel@x61.thuisdomein>
Message-ID: <201307141034.42868.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 July 2013, Paul Bolle wrote:
> The Kconfig symbol ARCH_MULTI_V4 was removed in commit 24e860fbfd
> ("ARM: multiplatform: always pick one CPU type"). Remove the last
> reference to it too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
> 
> 1) Commit 24e860fbfd is silent on the reason to drop ARCH_MULTI_V4. And
> the ARM section of the Kconfig files is rather complicated for people,
> like me, that aren't familiar with the way the ARM universe is divided
> in architectures, machines, platforms, etc. That makes it hard to say
> whether ARCH_MULTI_V4 was dropped on purpose or by accident.

It was dropped on purpose because it is unused in 3.11 but it will
be used again in 3.12, so I wouldn't bother with your patch.

Thanks anyway for looking into unused symbols, I think checking for
unused code like this is very useful in general.

	Arnd
