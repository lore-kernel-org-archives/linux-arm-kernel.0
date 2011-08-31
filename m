From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 31 Aug 2011 10:47:44 +0200
Subject: [PATCH] dmaengine: amba-pl08x: make filter check that the channel
	is owned by pl08x
In-Reply-To: <20110831083435.GD26905@n2100.arm.linux.org.uk>
References: <20110831083435.GD26905@n2100.arm.linux.org.uk>
Message-ID: <CAHXqBFKVx_AeA2Z_mXVnZg2O4Y2_7C6eKLqgS9-BDr58z4sYVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Before converting the dma channel to our private data structure, first
> check that the channel is indeed one which our driver registered. ?We
> do this by ensuring that the underlying device is bound to our driver.
>
> This avoids potential oopses if we try to reference 'plchan->name'
> against a foreign drivers dma channel.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?drivers/dma/amba-pl08x.c | ? 10 +++++++++-
> ?1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index be21e3f..91d4148 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -92,6 +92,8 @@
>
> ?#define DRIVER_NAME ? ?"pl08xdmac"
>
> +static struct amba_driver pl08x_amba_driver;
> +

This will make C++ coders confused a bit. Valid C, though.

Best Regards,
Micha? Miros?aw
