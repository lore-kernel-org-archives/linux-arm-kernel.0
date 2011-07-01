From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 1 Jul 2011 19:29:12 +0200
Subject: [PATCH 8/8] at91: add arch specific ioremap support
In-Reply-To: <201107011759.38038.arnd@arndb.de>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<1309502682-16897-8-git-send-email-plagnioj@jcrosoft.com>
	<201107011759.38038.arnd@arndb.de>
Message-ID: <20110701172912.GI14408@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:59 Fri 01 Jul     , Arnd Bergmann wrote:
> On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > +
> > +static inline unsigned int at91_readl(unsigned int pa)
> > +{
> > +	return __raw_readl((void __iomem *)AT91_IO_P2V(pa));
> > +}
> > +
> 
> This function looks quite unusual and not in a good way. You also don't
> seem to use it at all.
> 
> Why is this needed, can can't you change all users to do ioremap?
I don't remember why I put it

the whole idea is that everyone use ioremap now

Best Regards,
J.
