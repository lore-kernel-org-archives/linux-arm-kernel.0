From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 23 Jul 2013 13:58:12 +0200
Subject: [PATCH v3 01/31] spi: mpc512x: cleanup clock API use
In-Reply-To: <20130722140904.GU9858@sirena.org.uk>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-2-git-send-email-gsi@denx.de>
 <20130722140904.GU9858@sirena.org.uk>
Message-ID: <20130723115812.GG19071@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ devicetree at vger adjusted ]

On Mon, Jul 22, 2013 at 15:09 +0100, Mark Brown wrote:
> 
> On Mon, Jul 22, 2013 at 02:14:28PM +0200, Gerhard Sittig wrote:
> 
> > +	ret = clk_prepare_enable(clk);
> > +	if (ret) {
> > +		devm_clk_put(dev, clk);
> > +		goto free_irq;
> 
> The main point of the devm_ APIs is to avoid the need for explicit
> freeing so you should just remove these puts.

OK, will do in v4.

Shall these get removed everywhere including regular shutdown
paths, or just from error paths during setup?

[ the same topic came up for the CAN patch, might answer there ]


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
