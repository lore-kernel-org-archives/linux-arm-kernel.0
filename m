From: nm@ti.com (Nishanth Menon)
Date: Thu, 30 Oct 2014 08:55:03 -0500
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141029223104.GA23366@drone.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com> <5450EEE7.8070801@ti.com>
 <20141029185957.GA3723@earth.universe> <20141029193915.GB2542@atomide.com>
 <20141029214541.GA21790@kahuna>
 <20141029223104.GA23366@drone.musicnaut.iki.fi>
Message-ID: <54524337.8050608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 05:31 PM, Aaro Koskinen wrote:
> Also, you cannot expect all kernel users to know what you have been
> talking about. E.g. OMAP DMA API deprecation may have been discussed
> before, but I only learned it after the WARN appeared in the kernel tree.
> So you should start counting from that.
>
> Personally I don't mind if you delete OMAP3 legacy boot support already
> tomorrow morning, but if you want to give ~1 year transition period it
> should end somewhere in the end of 2015. Of course if there are no legacy
> boot users you can do it faster.

How about the following?

>
> +	WARN(!of_have_populated_dt(),
> +		"legacy booting deprecated(proposed removal in December 2015), please update to boot with .dts\n");
> +

Regards,
Nishanth Menon
