From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Aug 2012 22:03:49 +0100
Subject: Discontiguous memory and cacheflush
In-Reply-To: <502E6908.4070408@arm.com>
References: <1822556972.575011.1345068509111.JavaMail.root@mozilla.com>
 <502E6908.4070408@arm.com>
Message-ID: <20120817210349.GO18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 04:53:44PM +0100, Jonathan Austin wrote:
> (cacheflush.h:257)
> #define flush_cache_user_range(start,end) \
>         __cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
> 
> Does that have a bearing on what you're doing?

I'm going to do some digging over the weekend, and work out why that
was added.  I don't think it used to be the case that it flushed an
entire page.
