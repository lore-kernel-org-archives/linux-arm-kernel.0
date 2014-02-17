From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Feb 2014 21:09:54 +0000
Subject: Recent 3.x kernels: Memory leak causing OOMs
In-Reply-To: <1392670951.24429.10.camel@sakura.staff.proxad.net>
References: <20140216200503.GN30257@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1402161406120.26926@chino.kir.corp.google.com>
 <20140216225000.GO30257@n2100.arm.linux.org.uk>
 <1392670951.24429.10.camel@sakura.staff.proxad.net>
Message-ID: <20140217210954.GA21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:02:31PM +0100, Maxime Bizon wrote:
> 
> On Sun, 2014-02-16 at 22:50 +0000, Russell King - ARM Linux wrote:
> 
> > http://www.home.arm.linux.org.uk/~rmk/misc/log-20140208.txt
> 
> [<c0064ce0>] (__alloc_pages_nodemask+0x0/0x694) from [<c022273c>] (sk_page_frag_refill+0x78/0x108)
> [<c02226c4>] (sk_page_frag_refill+0x0/0x108) from [<c026a3a4>] (tcp_sendmsg+0x654/0xd1c)  r6:00000520 r5:c277bae0 r4:c68f37c0
> [<c0269d50>] (tcp_sendmsg+0x0/0xd1c) from [<c028ca9c>] (inet_sendmsg+0x64/0x70)
> 
> FWIW I had OOMs with the exact same backtrace on kirkwood platform
> (512MB RAM), but sorry I don't have the full dump anymore.
> 
> I found a slow leaking process, and since I fixed that leak I now have
> uptime better than 7 days, *but* there was definitely some memory left
> when the OOM happened, so it appears to be related to fragmentation.

However, that's a side effect, not the cause - and a patch has been
merged to fix that OOM - but that doesn't explain where most of the
memory has gone!

I'm presently waiting for the machine to OOM again (it's probably going
to be something like another month) at which point I'll grab the files
people have been mentioning (/proc/meminfo, /proc/vmallocinfo,
/proc/slabinfo etc.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
