From: davem@davemloft.net (David Miller)
Date: Thu, 18 Aug 2011 20:34:47 -0700 (PDT)
Subject: of_iomap() matched with plan iounmap()
In-Reply-To: <20110818170226.GA16721@huya.qualcomm.com>
References: <20110818170226.GA16721@huya.qualcomm.com>
Message-ID: <20110818.203447.462383652600224162.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Brown <davidb@codeaurora.org>
Date: Thu, 18 Aug 2011 10:02:26 -0700

> The SPARC target contains of_ioremap() and of_iounmap(), which various
> drivers use (generally inside of CONFIG_SBUS).
> 
> include/linux/of_address.h contains a definition for of_iomap(), but
> not corresponding unmap call.  Code using this calls the regular
> iounmap().
> 
> Is it safe to assume that of_iomap() will always be based on ioremap()
> and therefore it is safe to use iounmap(), or would it be better to
> define another name for drivers to use as the inverse of of_iomap().
> I'm not sure what to call it, since of_iounmap() is already taken by
> SPARC.

It's better to define a matching of_iounmap() interface, even if for
now it is exactly iounmap()
