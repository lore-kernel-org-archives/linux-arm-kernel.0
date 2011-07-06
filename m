From: mkl0301@gmail.com (Lin Mac)
Date: Thu, 7 Jul 2011 07:57:11 +0800
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
Message-ID: <CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/6 Anton Vorontsov <avorontsov@mvista.com>:
> CNS3xxx SOCs have L310-compatible cache controller, so let's use it.
>
> With this patch benchmarking with 'gzip' shows that performance is
> doubled, and I'm still able to boot full-fledged userland over NFS
> (using PCIe NIC), so the support should be pretty robust.
>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

CNS3xxx have PL310. Would you mind to enable CONFIG_CACHE_PL310 by
default as well? It is default disabled by !CPU_V6 of CACHE_PL310.

@@ -795,6 +795,7 @@ config CACHE_L2X0
        default y
        select OUTER_CACHE
        select OUTER_CACHE_SYNC
+       select CACHE_PL310 if ARCH_CNS3XXX
        help
          This option enables the L2x0 PrimeCell.

Best Regards,
Mac Lin
