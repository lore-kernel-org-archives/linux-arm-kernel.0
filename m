From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 11 Apr 2014 18:27:57 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod: fix missing braces in _init()
In-Reply-To: <1394788517-15014-1-git-send-email-rnayak@ti.com>
References: <1394788517-15014-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1404111827410.14347@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Mar 2014, Rajendra Nayak wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> Bug was introduced by commit 'f92d959: ARM: OMAP2+: hwmod:
> Extract no-idle and no-reset info from DT'
> 
> There were 2 versions of the patch posted which resulted in the above
> commit. While v1 [1] had the bug, v2 [2] had it fixed.
> However v1 apparently seemed to have been pulled in by mistake
> introducing the bug.
> 
> Given of_find_property() does return NULL when the node passed is
> NULL, it did not introduce any functional issues as such, just the
> fact that the second if check was executed unnecessarily.
> 
> [1] https://www.mail-archive.com/linux-omap at vger.kernel.org/msg94220.html
> [2] http://www.spinics.net/lists/linux-omap/msg98490.html
> 
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v3.15-rc.


- Paul
