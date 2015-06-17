From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Jun 2015 14:00:49 -0500
Subject: [PATCH v2] i2c: omap: improve duty cycle on SCL
In-Reply-To: <5581C3E5.6020109@gmail.com>
References: <1434565751-14944-1-git-send-email-balbi@ti.com>
 <5581C3E5.6020109@gmail.com>
Message-ID: <20150617190049.GI18421@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 09:00:53PM +0200, Alexander Sverdlin wrote:
> Hi!
> 
> On 17/06/15 20:29, Felipe Balbi wrote:
> > -		if (dev->speed > 400 ||
> > -			       dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
> > -			internal_clk = 19200;
> 
> Let's compare, what it waas before in this case...
> 
> > -		else if (dev->speed > 100)
> > -			internal_clk = 9600;
> > -		else
> > -			internal_clk = 4000;
> > +		if (dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK ||
> > +				dev->speed > 400) {
> > +			internal_clk = 1920000;
> 
> Seems that it should be 19200000? Because...

indeed, it's missing one 0. I don't have OMAP3 board to test that out,
that's why I asked Aaro to run the test. v3 coming.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/cd157eaa/attachment.sig>
