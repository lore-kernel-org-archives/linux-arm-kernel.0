From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 17:18:02 +0100
Subject: [PATCH 9/9] pinctrl: at91: add missing of_node_put
In-Reply-To: <1445697755-26341-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
 <1445697755-26341-10-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdYOMyhz_6G15UkLbp5Jo=7k98_i8p6NUgzOev=gCWNyDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 4:42 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

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

Patch applied with Ludovic's ACK.

Yours,
Linus Walleij
