From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Fri, 16 Oct 2015 23:48:25 +0300
Subject: [PATCH] memcg: include linux/mm.h
In-Reply-To: <14714191.7FdLxZ8X79@wuerfel>
References: <14714191.7FdLxZ8X79@wuerfel>
Message-ID: <20151016204825.GB1817@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 10:03:31PM +0200, Arnd Bergmann wrote:
> A recent change to the memcg code added a call to virt_to_head_page,
> which is declared in linux/mm.h, but this is not necessarily included
> here and will cause compile errors:
> 
> include/linux/memcontrol.h:841:9: error: implicit declaration of function 'virt_to_head_page' [-Werror=implicit-function-declaration]
> 
> This adds an explicit include statement that gets rid of the error.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1ead4c071978 ("memcg: simplify and inline __mem_cgroup_from_kmem")

http://lkml.kernel.org/g/20151016131726.GA602 at node.shutemov.name

-- 
 Kirill A. Shutemov
