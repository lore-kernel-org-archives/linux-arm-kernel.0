From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 20:03:14 +0100
Subject: [PATCH 09/13] ARM: LPC32XX: power and event management
In-Reply-To: <20100203164425.GK11354@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-10-git-send-email-wellsk40@gmail.com>
	<20100203164425.GK11354@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B7879B@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +/*
> > + * Wakeup event support
> > + */
> > +extern void lpc32xx_event_init(void);
> > +extern void lpc32xx_event_enable(enum lpc32xx_events event_id);
> > +extern void lpc32xx_event_disable(enum lpc32xx_events event_id);
> > +extern int lpc32xx_event_set(enum lpc32xx_events event_id,
> > +	int high_edge);
> > +extern int lpc32xx_event_enabled(enum lpc32xx_events event_id);
> > +extern void lpc32xx_event_clear(enum lpc32xx_events event_id);
> > +extern void lpc32xx_event_clear_all(void);
> This is usually plugged into set_irq_wake.  Isn't that generic enough
> for you?
> 

I'm not familiar with that yet. I'll look into it and rewrite the
handling if necessary. IRQ events and wakeup events are different
things on this device, although you can set an alarm wakeup event
with an alarm irq...or something like that..
