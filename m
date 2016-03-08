From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 7 Mar 2016 18:02:05 -0800
Subject: mmotm broken on arm with ebc495cfcea9 (mm: cleanup *pte_alloc*
 interfaces)
In-Reply-To: <56DE2A92.5010806@redhat.com>
References: <56DE2A92.5010806@redhat.com>
Message-ID: <20160307180205.1df26ec3.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Mar 2016 17:27:46 -0800 Laura Abbott <labbott@redhat.com> wrote:

> Hi,
> 
> I just tried the master of mmotm and ran into compilation issues on arm:
> 
> ...
>
> It looks like this is caused by ebc495cfcea9 (mm: cleanup *pte_alloc* interfaces)
> which added
> 
> #define pte_alloc(mm, pmd, address)                     \
>          (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd, address))
> 
> 

http://ozlabs.org/~akpm/mmots/broken-out/mm-cleanup-pte_alloc-interfaces-fix.patch
and
http://ozlabs.org/~akpm/mmots/broken-out/mm-cleanup-pte_alloc-interfaces-fix-2.patch
should fix up arm?
