From: vapier@gentoo.org (Mike Frysinger)
Date: Mon, 30 May 2011 01:00:21 -0400
Subject: [PATCH 1/4] clk: Add a generic clock infrastructure
In-Reply-To: <20110525104750.GA3959@richard-laptop>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.326305.518470530485.1.gpush@pororo>
	<20110525104750.GA3959@richard-laptop>
Message-ID: <201105300100.23541.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 25, 2011 06:47:50 Richard Zhao wrote:
> On Fri, May 20, 2011 at 03:27:49PM +0800, Jeremy Kerr wrote:
> > +struct clk {
> > +	const char		*name;
> > +	struct clk_hw_ops	*ops;
> > +	struct clk_hw		*hw;
> 
> If we don't let it void *, why not put clk_hw_ops into clk_hw too? It'll be
> more easy to define static clocks.

because the ops should be const, and possibly shared among multiple clocks.  
i.e. if i have 4 SPI buses, there should only be one copy of the ops structure 
but 4 clk_hw instances.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110530/617b00bc/attachment.sig>
