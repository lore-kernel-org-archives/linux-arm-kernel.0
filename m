From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 17:59:37 +0200
Subject: [PATCH 8/8] at91: add arch specific ioremap support
In-Reply-To: <1309502682-16897-8-git-send-email-plagnioj@jcrosoft.com>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<1309502682-16897-8-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <201107011759.38038.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:

> +
> +static inline unsigned int at91_readl(unsigned int pa)
> +{
> +	return __raw_readl((void __iomem *)AT91_IO_P2V(pa));
> +}
> +

This function looks quite unusual and not in a good way. You also don't
seem to use it at all.

Why is this needed, can can't you change all users to do ioremap?

	Arnd
