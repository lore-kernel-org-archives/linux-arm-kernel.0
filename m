From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Jan 2015 22:13:56 +0000
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <3495606.iOQOj3bxPc@wuerfel>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
 <54AEA7E0.5070101@gmail.com>
 <CADtm3G5Ebf6WkHG3fyiY3pm7fEBBNoW3DDEEwpvBXGj0fVE6jQ@mail.gmail.com>
 <3495606.iOQOj3bxPc@wuerfel>
Message-ID: <20150108221356.GD12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 11:10:47PM +0100, Arnd Bergmann wrote:
> My guess is that any implementation that has working LDREX/STREX
> on uncached memory does not support SMP, because these instructions
> tend to be implemented through the cache coherency logic on SMP
> systems but could be implemented more easily without a dcache
> on uniprocessor cores.

Yes, I negated Tony's patches... Tony was fixing pstore to use
writecombine memory.

So this change is fine.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
