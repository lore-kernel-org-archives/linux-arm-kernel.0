From: rientjes@google.com (David Rientjes)
Date: Wed, 11 Jun 2014 16:04:29 -0700 (PDT)
Subject: [PATCH] arm64: fix MAX_ORDER for 64K pagesize
In-Reply-To: <alpine.DEB.2.02.1406111557030.27885@chino.kir.corp.google.com>
References: <1402522435-13884-1-git-send-email-msalter@redhat.com>
 <alpine.DEB.2.02.1406111557030.27885@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.02.1406111604060.27885@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jun 2014, David Rientjes wrote:

> Any reason to not switch this to
> 
> 	ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE && CMA
> 

(ARM64_64K_PAGES) && (TRANSPARENT_HUGEPAGE || CMA)

> instead?  If pageblock_order > MAX_ORDER because of 
> HPAGE_SHIFT > PAGE_SHIFT, then cma is always going to be passing a 
> too-large-order to free_pages_prepare() via this path.
> 
> Adding Michal and Marek to the cc.
> 
