From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 22 Aug 2015 18:12:42 -0700
Subject: [PATCH 02/11] soc: ti: knav_qmss_queue: fix error return code
In-Reply-To: <1440288682-12732-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
 <1440288682-12732-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <55D91E0A.20602@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/15 5:11 PM, Julia Lawall wrote:
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
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
