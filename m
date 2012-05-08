From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 May 2012 09:36:18 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2/3: hwmod data: add gpmc
In-Reply-To: <1336481382-28583-1-git-send-email-afzal@ti.com>
References: <1336481382-28583-1-git-send-email-afzal@ti.com>
Message-ID: <alpine.DEB.2.00.1205080932560.9984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 8 May 2012, Afzal Mohammed wrote:

> This is patch 13/39 & 14/39 of v4 OMAP GPMC driver conversion
> series modified and squashed into one.

...

> +	/* HWMOD_INIT_NO_RESET can be removed once kernel is updated
> +	 * to configure GPMC for all peripherals, right now many
> +	 * peripherals depend on bootloader configuration, removing
> +	 * this flag would break GPMC on many boards
> +	 */

Thanks for combining these.   But since you're doing quite a bit of GPMC 
work, I think we should ensure that the kernel will configure the GPMC 
before accessing GPMC devices as part of this change.

See also 

   http://marc.info/?l=linux-omap&m=133649129220098&w=2


- Paul
