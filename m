From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 16:23:51 +0200
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
Message-ID: <201107061623.51969.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Anton Vorontsov wrote:
> CNS3xxx SOCs have L310-compatible cache controller, so let's use it.
> 
> With this patch benchmarking with 'gzip' shows that performance is
> doubled, and I'm still able to boot full-fledged userland over NFS
> (using PCIe NIC), so the support should be pretty robust.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> 
> I'm going to apply it to linux-cns3xxx.git tree and push it (via Arnd)
> for v3.1 , if there will be no complains, of course.

I think there is a small problem you should fix first, but otherwise
it's ok.

The problem is that CONFIG_CACHE_L2X0 is a compile-time option that
can be disabled. Your code will not link correctly if it's turned off,
so you need to contitionalize it on that Kconfig symbol.

	Arnd
