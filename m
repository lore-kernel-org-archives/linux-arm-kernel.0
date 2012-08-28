From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 28 Aug 2012 10:08:07 +0800
Subject: [PATCH v2 4/7] regulator: anatop-regulator: convert to use
 syscon to access anatop register
In-Reply-To: <20120827221532.GC2281@r65073-Latitude-D630>
References: <1346052285-4344-1-git-send-email-b29396@freescale.com>
 <1346052285-4344-5-git-send-email-b29396@freescale.com>
 <20120827221532.GC2281@r65073-Latitude-D630>
Message-ID: <20120828020806.GE5822@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 06:15:35AM +0800, Shawn Guo wrote:
....
> > +	sreg->anatop = syscon_regmap_lookup_by_phandle(np, "fsl,anatop");
> > +	if (IS_ERR(sreg->anatop))
> > +		return PTR_ERR(sreg->anatop);
> > +
> 
> All the anatop regulators are child nodes of anatop.  It looks a little
> odd to use phandle there.  of_get_parent should just works.
> 
Yes, this is a special case.
It's also ok for me to use of_get_parent if you want.
Will update it.

Regards
Dong Aisheng
