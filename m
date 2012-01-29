From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jan 2012 00:11:36 +0000
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
 <1327574142.2355.30.camel@hornet.cambridge.arm.com>
 <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
Message-ID: <20120129001136.GB15455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2012 at 11:55:19PM +0100, Joachim Eastwood wrote:
> "ARM: 7304/1: ioremap: fix boundary check when reusing static mapping"
> Commit: 3c424f359898aff48c3d5bed608ac706f8a528c3 in Linus master
> 
> Breaks booting on my custom AT91RM9200 board.
> There isn't any error messages or anything that indicates what goes
> wrong it just stops after; Uncompressing Linux... done, booting the
> kernel.

Your best way of finding out what's going on is to enable:

DEBUG_KERNEL
DEBUG_LL
EARLY_PRINTK

and select the appropriate kernel low-level debugging port.  That should
show you what's going on.
