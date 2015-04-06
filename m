From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 05 Apr 2015 19:03:15 -0700
Subject: [PATCH 14/16] soc: ti: knav_qmss_queue: fix error return code
In-Reply-To: <1428235596-4757-15-git-send-email-Julia.Lawall@lip6.fr>
References: <1428235596-4757-1-git-send-email-Julia.Lawall@lip6.fr>
 <1428235596-4757-15-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <5521E963.5080903@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/15 5:06 AM, Julia Lawall wrote:
> Return a negative error code on failure.
>
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret != 0\))
>   { ... return ret; }
> |
> ret = 0
> )
> ... when != ret = e1
>      when != &ret
> *if(...)
> {
>    ... when != ret = e2
>        when forall
>   return ret;
> }
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
