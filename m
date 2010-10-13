From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Oct 2010 09:09:02 +0100
Subject: [PATCH v2 4/6] ARM: S5P: Add EPLL rate change warning
In-Reply-To: <002301cb6aac$12a05e10$37e11a30$%kim@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
	<1286883983-27790-1-git-send-email-sw.youn@samsung.com>
	<002301cb6aac$12a05e10$37e11a30$%kim@samsung.com>
Message-ID: <20101013080902.GA6424@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 04:55:55PM +0900, Kukjin Kim wrote:
> Seungwhan Youn wrote:

> > This patch adds warning about changing EPLL rate to notice that other
> > driver that controls H/W, which is using EPLL, will has unknown effects
> > by this EPLL rate change.

> > +	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
> > +			clk->rate, rate);

> Do we really need KERN_WARNING here?
> How about just KERN_INFO?...In my opinion, to change EPLL value seems to be
> nearer 'information' message more than 'warning'.

Personally I don't think it really makes much odds so long as the
message is displayed on the console by default.
