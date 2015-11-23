From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Nov 2015 15:26:18 +0800
Subject: [PATCH 2/4] mtd: nand: sunxi: add missing of_node_put
In-Reply-To: <1447884254-26336-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447884254-26336-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAGb2v64R1729v48dBZW15MuBjqJ4vqJGnFPEDgaGDN55mszseA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 6:04 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
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

Acked-by: Chen-Yu Tsai <wens@csie.org>
