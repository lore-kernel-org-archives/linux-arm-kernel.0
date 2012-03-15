From: sr@denx.de (Stefan Roese)
Date: Thu, 15 Mar 2012 09:48:27 +0100
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <4F604321.9000204@st.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <4F604321.9000204@st.com>
Message-ID: <201203150948.27918.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh,

On Wednesday 14 March 2012 08:05:05 Viresh Kumar wrote:
> > +static const char *spear600_dt_board_compat[] = {
> > +	"st,spear600-evb",
> > +	NULL
> > +};
> > +
> > +static const struct of_device_id vic_of_match[] __initconst = {
> > +	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
> > +	{ /* Sentinel */ }
> > +};
> > +
> > +static void __init spear6xx_dt_init_irq(void)
> > +{
> > +	of_irq_init(vic_of_match);
> > +}
> > +
> 
> What about adding this routine in vic.c file, which can then be used
> by all platforms, instead of replicating this code.

We can't move vic_of_match to the vic.c, since there are differences between 
the boards using it. And only moving spear6xx_dt_init_irq() (renamed of 
course) doesn't seem worth it.

Thanks,
Stefan
