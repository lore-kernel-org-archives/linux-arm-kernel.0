From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Jan 2012 09:13:28 -0800
Subject: [PATCH 5/7] ARM: OMAP2+: hwmod: add omap_hwmod_get_mpu_irq()
 and omap_hwmod_get_mpu_rt_pa()
In-Reply-To: <20120130101816.10450.2624.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
 <20120130101816.10450.2624.stgit@dusk>
Message-ID: <20120130171327.GD9339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Paul Walmsley <paul@pwsan.com> [120130 01:47]:
> The timer integration code pokes around in hwmod data structures.
> Those data structures are about to change.  Define some functions for
> the timer integration code to use instead.

Maybe these should use struct resource instead to make these more
generic? Something like this maybe:

int omap_hwmod_get_resource(struct omap_hwmod *oh, unsigned int type,
				unsigned int num, struct resource *r);

Then the calling code would do:

	...
	struct resource r;
	int res;

	res = omap_hwmod_get_resource(oh, IORESOURCE_IRQ, 0, &r);
	...

Regards,

Tony
