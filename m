From: hannes@cmpxchg.org (Johannes Weiner)
Date: Fri, 18 Dec 2015 11:42:09 -0500
Subject: [PATCH] memcg: fix SLOB build regression
In-Reply-To: <13705081.IYJlPWfILN@wuerfel>
References: <13705081.IYJlPWfILN@wuerfel>
Message-ID: <20151218164209.GD4201@cmpxchg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 03:35:06PM +0100, Arnd Bergmann wrote:
> A recent cleanup broke the build when CONFIG_SLOB is used:
> 
> mm/memcontrol.c: In function 'memcg_update_kmem_limit':
> mm/memcontrol.c:2974:9: error: implicit declaration of function 'memcg_online_kmem' [-Werror=implicit-function-declaration]
> mm/memcontrol.c: In function 'mem_cgroup_css_alloc':
> mm/memcontrol.c:4229:10: error: too many arguments to function 'memcg_propagate_kmem'
> mm/memcontrol.c:2949:12: note: declared here
> 
> This fixes the memcg_propagate_kmem prototype to match the normal
> implementation and adds the respective memcg_online_kmem helper
> function that was needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a5ed904c5039 ("mm: memcontrol: clean up alloc, online, offline, free functions")

I am slob.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
