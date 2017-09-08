From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 8 Sep 2017 16:28:25 +0200
Subject: [PATCH v5 10/10] net: stmmac: dwmac-sun8i: Handle
 integrated/external MDIOs
In-Reply-To: <20170908141736.GF25219@lunn.ch>
References: <20170908071156.5115-1-clabbe.montjoie@gmail.com>
 <20170908071156.5115-11-clabbe.montjoie@gmail.com>
 <20170908130520.GA11248@lunn.ch> <20170908132632.GA3037@Red>
 <20170908140020.GC25219@lunn.ch> <20170908140832.GB3037@Red>
 <20170908141736.GF25219@lunn.ch>
Message-ID: <20170908142825.GC3037@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 04:17:36PM +0200, Andrew Lunn wrote:
> > > Do you know why the reset times out/fails?
> > > 
> > 
> > Because there are nothing connected to it.
> 
> That should not be an issue. A read should just return 0xffff.  And it
> should return 0xffff fast. The timing of the MDIO protocol is fixed. A
> read or a write takes a fixed number of cycles, independent of if
> there is a device there or not. The bus data line has a pullup, so if
> you try to access a missing device, you automatically read 0xffff.
> 

Perhaps, but the reality is that with nothing connected to it, the reset of the MAC timeout.
Certainly, the MAC does not support finding no PHY.

So, to prevent an error message, and a "freeze" of the net process, the need_reset trick is necessary.

Regards
Corentin Labbe
