From: coelho@ti.com (Luciano Coelho)
Date: Sat, 20 Jul 2013 10:48:08 +0300
Subject: [PATCH] Documentation: dt: bindings: TI WiLink modules
In-Reply-To: <1698879.DLaB5pbe5M@avalon>
References: <1372149330-24335-1-git-send-email-coelho@ti.com>
 <1372425670.21065.61.camel@cumari.coelho.fi>
 <1372682370.21065.68.camel@cumari.coelho.fi> <1698879.DLaB5pbe5M@avalon>
Message-ID: <1374306488.8385.56.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-07-18 at 01:58 +0200, Laurent Pinchart wrote:
> Hi Luciano,

Hi Laurent,

> On Monday 01 July 2013 15:39:30 Luciano Coelho wrote:
> > The only thing I can come up with is to make a small clock driver (maybe
> > even inside the WiLink module itself) that registers a new type of
> > clock, "ti,wilink-clock" or something.  But this would really be
> > overkill, wouldn't it?
> > 
> > Any other ideas?
> 
> One possibility would be to just call clk_get_rate() on the clock from the 
> WiLink driver, which would return the fixed frequency specified in DT, and 
> configure the WiLink hardware accordingly. This might be a bit hackish though.

The problem is not get the rate itself, the problem is knowing whether
the clock is XTAL or not.  The WiLink chip uses the clock in a slightly
different way if it is XTAL, due to some stabilization time constraints.

--
Luca.
