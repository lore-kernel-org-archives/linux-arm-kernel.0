From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Dec 2011 10:15:00 -0800
Subject: [PATCH v4 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be
 more maintainable
In-Reply-To: <20111214120314.GA9841@oksana.dev.rtsoft.ru>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-2-git-send-email-dave.martin@linaro.org>
 <20111214120314.GA9841@oksana.dev.rtsoft.ru>
Message-ID: <20111214181500.GC32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Anton Vorontsov <cbouatmailru@gmail.com> [111214 03:31]:
> On Wed, Dec 14, 2011 at 11:39:37AM +0000, Dave Martin wrote:
> > Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> > is bothersome to maintain and likely to lead to merge conflicts.
> > 
> > This patch moves the knowledge of which platforms have a L2x0 or
> > PL310 cache controller to the individual machines.  To enable this,
> > a new MIGHT_HAVE_CACHE_L2X0 config option is introduced to allow
> > machines to indicate that they may have such a cache controller
> > independently of each other.
> > 
> > Boards/SoCs which cannot reliably operate without the L2 cache
> > controller support will need to select CACHE_L2X0 directly from
> > their own Kconfigs instead.  This applies to some TrustZone-enabled
> > boards where Linux runs in the Normal World, for example.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> For CNS3xxx bits:
> 
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

For omap:

Acked-by: Tony Lindgren <tony@atomide.com>
