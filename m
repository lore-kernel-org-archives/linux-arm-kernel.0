From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Nov 2012 15:21:21 -0800
Subject: [PATCH] ARM: OMAP1: use BUG_ON where possible
In-Reply-To: <1352406191-14303-7-git-send-email-sasha.levin@oracle.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
 <1352406191-14303-7-git-send-email-sasha.levin@oracle.com>
Message-ID: <20121112232120.GX6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sasha Levin <sasha.levin@oracle.com> [121108 12:26]:
> Just use BUG_ON() instead of constructions such as:
> 
> 	if (...)
> 		BUG()
> 
> A simplified version of the semantic patch that makes this transformation
> is as follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e;
> @@
> - if (e) BUG();
> + BUG_ON(e);
> // </smpl>
> 
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>

Thanks applying into omap-for-v3.8/board-v2.

Regards,

Tony
