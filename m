From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 30 Aug 2012 10:19:19 -0700
Subject: [PATCH] clk: Make the generic clock API available by default
In-Reply-To: <503E8E6E.1010101@wwwdotorg.org>
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <503E8E6E.1010101@wwwdotorg.org>
Message-ID: <20120830171918.GE4356@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 02:49:34PM -0700, Stephen Warren wrote:
> On 08/28/12 13:35, Mark Brown wrote:

> >@@ -674,6 +676,7 @@ config ARCH_TEGRA
> >  	select GENERIC_CLOCKEVENTS
> >  	select GENERIC_GPIO
> >  	select HAVE_CLK
> >+	select HAVE_CUSTOM_CLK

> For 3.7, Tegra will switch to the common clock framework. I think
> this patch would then disable that. How should we resolve this -
> rebase the Tegra common-clk tree on top of any branch containing
> this patch in order to remove that select statement?

I'd expect this to be applied on a separate branch so you should be able
to rebase your conversion on top of it or merge it into your branch
which should deal with things well enough I think?
