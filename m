From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Jan 2014 13:11:56 +0000
Subject: Warning at __kmem_cache_create
In-Reply-To: <CAOMZO5Cbws-Kj-q63iCAFFOyR7gm24Z+VUZTAdzeOgud3B4cjQ@mail.gmail.com>
References: <CAOMZO5Cbws-Kj-q63iCAFFOyR7gm24Z+VUZTAdzeOgud3B4cjQ@mail.gmail.com>
Message-ID: <20140124131156.GE15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 11:01:17AM -0200, Fabio Estevam wrote:
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
>     lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
>     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
>       .text : 0x80008000 - 0x807e0edc   (8036 kB)
>       .init : 0x807e1000 - 0x8082e300   ( 309 kB)
>       .data : 0x80830000 - 0x8088b900   ( 367 kB)
>        .bss : 0x8088b908 - 0x80debdb0   (5506 kB)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at mm/slub.c:1511 __kmem_cache_create+0x24c/0x318()

I don't tend to track linux-next as I don't have the capacity to.
arm-soc and their autobuilder and autobooter do, but they only provide
abbreviated results when things actually result in a failure to boot.
It would be better if that facility had the provision for full boot
logs as mine does.

Just looked in my trees (which includes arm-soc), and 1511 doesn't
correspond with anything that issues a warning.  I just booted Linus'
tip on the cubox-i4, and it booted without warning.

So it's some slub change which has yet to hit mainline... I can't say
much more than that at the moment.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
