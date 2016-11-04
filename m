From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 5 Nov 2016 00:26:49 +0100
Subject: [PATCH RFC 1/7] dma: pl08x: Add support for the DMA slave map
In-Reply-To: <1478276094-19135-3-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <201611050026.49560.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 November 2016, Sylwester Nawrocki wrote:
> +       } else {
> +               pl08x->slave.filter.map = pl08x->pd->slave_map;
> +               pl08x->slave.filter.mapcnt = pl08x->pd->slave_map_len;
>         }

I think you miss the setup of the filter function here.

Filtering by string in this driver is a bit awkward, so I wonder if we
might want to go one step further here and pass the actual data (i.e. 
struct pl08x_channel_data) rather than the string here.

	Arnd
