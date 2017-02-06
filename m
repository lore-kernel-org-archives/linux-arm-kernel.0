From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 6 Feb 2017 14:48:08 +0100
Subject: [PATCH net-next v5 3/4] net: phy: Allow pre-declaration of MDIO
 devices
In-Reply-To: <20170204210245.14812-4-f.fainelli@gmail.com>
References: <20170204210245.14812-1-f.fainelli@gmail.com>
 <20170204210245.14812-4-f.fainelli@gmail.com>
Message-ID: <20170206134808.GG32506@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 8a57f0b1242d..8850fcaf50db 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -501,6 +501,7 @@ struct platform_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +#define MDIO_NAME_SIZE		32

...

> +struct mdio_board_info {
> +	const char	*bus_id;
> +	char		modalias[MDIO_NAME_SIZE];
> +

I think it might be better to use MII_BUS_ID_SIZE. These are all
related, so using one define should avoid surprise buffer overruns,
truncation's.

	Andrew
