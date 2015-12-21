From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Dec 2015 22:20:02 +0100
Subject: [PATCH 4/5] pinctrl: rockchip: add missing of_node_put
In-Reply-To: <1450715988-4770-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
 <1450715988-4770-5-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <2055001.xH02id89et@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

Am Montag, 21. Dezember 2015, 17:39:47 schrieb Julia Lawall:
> for_each_child_of_node performs an of_node_get on each iteration, so a
> return from the loop requires an of_node_put.
> 
> A simplified version of the semantic patch that fixes this problem is as
> follows (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> local idexpression n;
> expression e,e1;
> @@
> 
>  for_each_child_of_node(e1,n) {
>    ...
> (
>    of_node_put(n);
> 
>    e = n
> 
>    return n;
> 
> +  of_node_put(n);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

thanks for catching this :-)

I still remember how we talked about that same issue in the phy driver and the 
things for_each_child_of_node does when running, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko
