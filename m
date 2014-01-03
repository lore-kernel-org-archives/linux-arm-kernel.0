From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 12:22:06 +0000
Subject: ARM: mm: Could I change module space size or place modules in
 vmalloc area?
In-Reply-To: <201401031310.09930.arnd@arndb.de>
References: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
 <201401031310.09930.arnd@arndb.de>
Message-ID: <20140103122206.GK7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 01:10:09PM +0100, Arnd Bergmann wrote:
> Aside from the good comments that Russell made, I would remark that the
> fact that you need multiple megabytes worth of modules indicates that you
> are doing something wrong. Can you point to a git tree containing those
> modules?

>From the comments which have been made, one point that seems to have
been identified is that if this module is first stripped and then
loaded, it can load, but if it's unstripped, it's too big.  This sounds
suboptimal to me - the debug info shouldn't be loaded into the kernel.

However, I guess there's bad interactions with module signing if you
don't do this and the module was signed with the debug info present,
so I don't think there's a good solution for this.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
