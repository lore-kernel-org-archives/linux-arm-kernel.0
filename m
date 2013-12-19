From: tj@kernel.org (Tejun Heo)
Date: Thu, 19 Dec 2013 14:42:37 -0500
Subject: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
In-Reply-To: <20131219191027.GI4143@lunn.ch>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
 <52B140F2.8070900@ti.com> <20131218121313.GC4324@htj.dyndns.org>
 <20131219191027.GI4143@lunn.ch>
Message-ID: <20131219194237.GC22725@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 19, 2013 at 08:10:27PM +0100, Andrew Lunn wrote:
> > Shouldn't it distinguish between failures and at least produce
> > warning?  ie. phy not available and phy init failed due to memory
> > pressure or whatnot shouldn't be handled the same.
> 
> Phy not available is not an error, since not all variants of the SATA
                          ^
			 always

> IP block have the ability to control the phy. I can however add a
> warning for real errors.

Yes, please.

> > > > @@ -4132,6 +4148,8 @@ err:
> > > >  			clk_disable_unprepare(hpriv->port_clks[port]);
> > > >  			clk_put(hpriv->port_clks[port]);
> > > >  		}
> > > > +		if (!IS_ERR(hpriv->port_phys[port]))
> > > > +			phy_power_off(hpriv->port_phys[port]);
> > 
> > And I'd much prefer the array holds either NULL or valid pointer.
> 
> I was trying to keep the code similar to the clk handling. However now
> that it is diverging more and more from how clk is handled, i can add
> yet more divergence and overwrite the error with a NULL.

Thanks.

-- 
tejun
