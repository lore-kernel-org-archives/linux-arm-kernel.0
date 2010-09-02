From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 12:31:06 +0100
Subject: [PATCH] ep93xx: move clock initialization earlier
In-Reply-To: <1283363460-25825-1-git-send-email-mika.westerberg@iki.fi>
References: <1283363460-25825-1-git-send-email-mika.westerberg@iki.fi>
Message-ID: <20100902113106.GA26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 08:51:00PM +0300, Mika Westerberg wrote:
> Commit 7cfe24947 ("ARM: AMBA: Add pclk support to AMBA bus infrastructure")
> changed AMBA bus to handle the PCLK automatically. However, in EP93xx clock
> initialization is arch_initcall() which is done later than AMBA device
> identification. This causes amba_get_enable_pclk() to fail resulting device
> where UARTs are not functional.
> 
> So move clock initialization code before any AMBA device registration.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
> Note that I'm not sure whether ep93xx_map_io() is the best place for calling
> clock init code. Alternative would be to put it in ep93xx_init_devices() just
> before calls to amba_device_register().

Use core_initcall() or postcore_initcall() instead.
