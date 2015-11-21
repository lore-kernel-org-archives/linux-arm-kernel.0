From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Nov 2015 21:39:58 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <7199523.6J0A1gxY4q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 17:23:14 Stephen Boyd wrote:
> This is a respin of a patch series from about a year ago[1]. I realized
> that we already had most of the code in recordmcount to figure out
> where we make calls to particular functions, so recording where
> we make calls to the integer division functions should be easy enough
> to add support for in the same codepaths. Looking back on the thread
> it seems like Mans was thinking along the same lines, although it wasn't
> obvious to me back then or even over the last few days when I wrote this.

Shouldn't we start by allowing to build the kernel for -march=armv7ve
on platforms that allow it? That would seem like a simpler change
and likely generate better code for most people, except when you actually
care about running the same binary kernel on older platforms.

I tried to get a complete list of CPU cores with idiv, lpae and
virtualization support at some point, but I don't remember the
details for all Qualcomm and Marvell cores any more, to create the
complete configuration matrix. IIRC, all CPUs that support
virtualization also do lpae (they have to) and all CPUs that
do lpae also do idiv, but the opposite is not true.

	Arnd
