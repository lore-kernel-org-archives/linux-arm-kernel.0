From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 15:55:55 +0200
Subject: [PATCH 1/3] ARM: at91: use chipid device for soc detection
In-Reply-To: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
References: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <55618572.U3p4crGV1Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 March 2016 08:21:19 Ludovic Desroches wrote:
> -struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
> +int __init at91_get_cidr_exid_from_dbgu(u32 *cidr, u32 *exid)
>  {


> +
> +int __init at91_get_cidr_exid_from_chipid(u32 *cidr, u32 *exid)
> +{
> 

These should both be 'static', right?

	Arnd
