From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 Feb 2011 15:44:24 -0800
Subject: [PATCH v5 0/5] omap: mailbox: hwmod support
In-Reply-To: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Wed, 2 Feb 2011 13:27:18 -0600")
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <87ei7igkh3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> Mailbox hwmod support for OMAP 2,3,4.
>
> This was tested on OMAP3 (3430, 3630), minor testing
> was made on OMAP4.
>
> No testing on OMAP2 since I don't have the hardware.

Reviewed-by: Kevin Hilman <khilman@ti.com>

But still needs sanity testing on OMAP2.

Kevin

> Highlights from v5 include the comments received from
> previous version v4[1].
>
> Benoit Cousson (1):
>   OMAP4: hwmod data: add mailbox data
>
> Felipe Contreras (2):
>   OMAP3: hwmod data: add mailbox data
>   OMAP: mailbox: build device using omap_device/omap_hwmod
>
> Omar Ramirez Luna (1):
>   OMAP: mailbox: use runtime pm for clk and sysc handling
>
> omar ramirez (1):
>   OMAP2: hwmod data: add mailbox data
>
>  arch/arm/mach-omap2/devices.c              |   98 +++++-----------------------
>  arch/arm/mach-omap2/mailbox.c              |   67 ++-----------------
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   74 +++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   73 +++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   72 ++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 +++++++++++++++++++
>  6 files changed, 308 insertions(+), 143 deletions(-)
>
> ---
> [1] http://bit.ly/gfLaIs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
