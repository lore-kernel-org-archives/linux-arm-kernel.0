From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Apr 2011 09:40:41 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <alpine.LFD.2.00.1104102157440.28032@xanadu.home>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
Message-ID: <20110411074041.GF18601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2011 at 10:02:03PM -0400, Nicolas Pitre wrote:
> On Sun, 10 Apr 2011, Uwe Kleine-K?nig wrote:
> 
> > The two SoCs have different PHYS_OFFSETs so it's not (yet) possible to
> > compile a single (working) kernel for these.
> 
> Really?
> 
> Have a look at CONFIG_ARM_PATCH_PHYS_VIRT.  It's in mainline and fully 
> functional.
I'm aware of this config item. But still if it's off there must be a
distinction that's provided by this patch. Currently you can build a
kernel for i.MX51 + i.MX53 but IIRC it works on no machine.
When considering ARM_PATCH_PHYS_VIRT there are more SoCs that could be
built into a single image and so needs a more complicated logic.
And I don't want to depend on ARM_PATCH_PHYS_VIRT (yet), e.g. because
it's new and still depends on EXPERIMENTAL.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
