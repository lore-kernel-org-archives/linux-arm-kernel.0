From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Aug 2010 16:40:35 +0100
Subject: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
In-Reply-To: <20100817141210.GJ12184@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100817135205.GC20325@n2100.arm.linux.org.uk>
	<20100817141210.GJ12184@atomide.com>
Message-ID: <20100817154035.GD20325@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 05:12:11PM +0300, Tony Lindgren wrote:
> Great, will give it a try hopefully tomorrow. Sounds like that's the way
> to deal with fixing up things when booting up older UP ARMv6 without the
> 32v6 support :)

What I've also been debating about is adding another word to the
smpalt structure, that being a set of flags which denote the situation
where the alternative should be used.

That means we can use it to do individual word replacements for SMP vs
UP, ARMv6 vs ARMv6k etc.
