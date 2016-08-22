From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 15:43:23 +0200
Subject: [PATCH v3 02/12] mailbox: Add Tegra HSP driver
In-Reply-To: <20160819173233.13260-3-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-3-thierry.reding@gmail.com>
Message-ID: <13954058.6YHDe1jCOJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 19, 2016 7:32:23 PM CEST Thierry Reding wrote:
> +static int tegra_hsp_doorbell_send_data(struct tegra_hsp_channel *channel,
> +                                       void *data)
> +{
> +       tegra_hsp_channel_writel(channel, 1, HSP_DB_TRIGGER);
> +
> +       return 0;
> +}
> 

It seems very odd that you don't write the data at all but just trigger
the communication here. My interpretation is that you bypass
the mailbox infrastructure for the actual message, and instead reimplement
it on top of the mailbox infrastructure as part of the bpmp driver.

Why not expose the bpmp itself as the mailbox here?

	Arnd
