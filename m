From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Mon, 26 Jan 2015 13:32:42 -0800
Subject: [PATCH] drivers: net: xgene: fix: Out of order descriptor bytes
 read
In-Reply-To: <1422307652.29618.30.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1421957007-720-1-git-send-email-isubramanian@apm.com>
 <1421967050.3471.14.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAKh23FmxvV82mVrHq5jv-FE+e6u6CkW+xL_a2_ULAQgP_mM2VA@mail.gmail.com>
 <1422307652.29618.30.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <1422307962.29618.31.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-26 at 13:27 -0800, Eric Dumazet wrote:

> What happens if you compile a kernel with CONFIG_SMP=n ?
> 
> 
> Most drivers in drivers/net use rmb() in this case, not smp_rmb() or
> barrier()

Note that dma_rmb() was recently added as well.
