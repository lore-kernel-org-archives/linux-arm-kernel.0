From: vapier@gentoo.org (Mike Frysinger)
Date: Mon, 30 May 2011 01:20:11 -0400
Subject: [PATCH 0/4] Add a generic struct clk
In-Reply-To: <1305876469.325655.313573683829.0.gpush@pororo>
References: <1305876469.325655.313573683829.0.gpush@pororo>
Message-ID: <201105300120.12633.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 20, 2011 03:27:49 Jeremy Kerr wrote:
> [This series was originally titled 'Add a common struct clk', but
> the goals have changed since that first set of patches. We're now aiming
> for a more complete generic clock infrastructure, rather than just
> abstracting struct clk]
> 
> [This series still needs work, see the TODO section below]

for future series, could you cc uclinux-dist-devel at blackfin.uclinux.org ?  we 
dont do clock management on Blackfin parts atm, but it's something we would 
like to start doing.  our hardware can easily benefit from this.

basically, we have:
xtal -> pll -> divider -> core clock -> divider -> core timer
		\-> divider -> system clock
					|-> spi divider -> spi clock
					|-> i2c divider -> i2c clock
					|-> uart divider -> uart clock
					...etc...
and future parts are only going to get more complicated trees.

atm we only support changing core clock on the fly since it requires 
reprogramming one device (the core timer).  we'd like to support changing the 
other clocks on the fly, but have no framework for doing so.  this obviously 
would address that.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110530/ef7cabf9/attachment.sig>
