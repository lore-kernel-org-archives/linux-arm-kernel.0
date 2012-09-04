From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 4 Sep 2012 19:27:04 +0800
Subject: [PATCH v5 3/4] regulator: anatop-regulator: convert to use
 syscon to access anatop register
In-Reply-To: <20120904113429.GK2362@S2101-09.ap.freescale.net>
References: <1346728811-25788-1-git-send-email-b29396@freescale.com>
 <1346728811-25788-4-git-send-email-b29396@freescale.com>
 <20120904113429.GK2362@S2101-09.ap.freescale.net>
Message-ID: <20120904112703.GA13046@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 07:34:32PM +0800, Shawn Guo wrote:
> On Tue, Sep 04, 2012 at 11:20:10AM +0800, Dong Aisheng wrote:
> > +
> > +	anatop_np = of_get_parent(np);
> > +	if (!anatop_np)
> > +		return -ENODEV;
> > +	sreg->anatop = syscon_node_to_regmap(anatop_np);
> > +	if (IS_ERR(sreg->anatop))
> > +		return PTR_ERR(sreg->anatop);
> > +
> With of_node_put moved out from syscon_node_to_regmap, shouldn't
> we put anatop_np here then?
> 
When i sent it out, i found i missed it...
Should be more care...

Regards
Dong Aisheng
