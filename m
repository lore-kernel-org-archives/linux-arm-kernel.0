From: khilman@ti.com (Kevin Hilman)
Date: Mon, 01 Aug 2011 15:11:57 -0700
Subject: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
	platform_device from omap_device
In-Reply-To: <20110801200743.GA21535@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 1 Aug 2011 21:07:43 +0100")
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-9-git-send-email-khilman@ti.com>
	<20110730120332.GA15539@n2100.arm.linux.org.uk>
	<20110731025807.GA24334@ponder.secretlab.ca>
	<20110731150540.GA3019@n2100.arm.linux.org.uk> <871ux5nnop.fsf@ti.com>
	<CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
	<20110801185009.GA5217@legolas.emea.dhcp.ti.com>
	<20110801200743.GA21535@n2100.arm.linux.org.uk>
Message-ID: <87pqkon5n6.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Help the typechecker do its job.  As we have only one (at the moment...)
> And make it:
>
> +struct omap_device;
>
>  struct pdev_archdata {
> +#ifdef CONFIG_ARCH_OMAP
> +	struct omap_device *omap;
> +#endif
>  };
>
> for bonus points, so we only get the additional pointer for OMAP.

OK, will do it this way.

Kevin
