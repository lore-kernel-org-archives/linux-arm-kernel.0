From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 23 Nov 2015 14:59:15 +0100
Subject: [PATCH 2/4] mtd: nand: sunxi: add missing of_node_put
In-Reply-To: <1447884254-26336-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447884254-26336-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20151123145915.04ed6508@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015 23:04:12 +0100
Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> for_each_child_of_node performs an of_node_get on each iteration, so
> a break out of the loop requires an of_node_put.
> 
> A simplified version of the semantic patch that fixes this problem is as
> follows (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> @@
> 
>  for_each_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> (
>    return child;
> |
> +  of_node_put(child);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
