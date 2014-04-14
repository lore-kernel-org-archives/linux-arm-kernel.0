From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 11:33:16 +0200
Subject: [PATCH 05/29] memory: mvebu-devbus: use ARMADA_ prefix in defines
In-Reply-To: <1397400006-4315-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BAB5C.6020703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> The mvebu-devbus driver currently only supports the Armada 370/XP
> family, but it can also cover the Orion5x family. However, the Orion5x
> family has a different organization of the register. Therefore, in
> preparation to the introduction of Orion5x support, we rename the
> Armada 370/XP specific definitions to have an ARMADA_ prefix.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   drivers/memory/mvebu-devbus.c | 48 +++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
> index b82cdf1..84746e3 100644
> --- a/drivers/memory/mvebu-devbus.c
> +++ b/drivers/memory/mvebu-devbus.c
> @@ -30,19 +30,19 @@
>   #include <linux/platform_device.h>
>
>   /* Register definitions */
> -#define DEV_WIDTH_BIT		30
> -#define BADR_SKEW_BIT		28
> -#define RD_HOLD_BIT		23
> -#define ACC_NEXT_BIT		17
> -#define RD_SETUP_BIT		12
> -#define ACC_FIRST_BIT		6
> +#define ARMADA_DEV_WIDTH_BIT		30
> +#define ARMADA_BADR_SKEW_BIT		28
> +#define ARMADA_RD_HOLD_BIT		23
> +#define ARMADA_ACC_NEXT_BIT		17
> +#define ARMADA_RD_SETUP_BIT		12
> +#define ARMADA_ACC_FIRST_BIT		6

I guess the correct terminology would be _SHIFT.
Also, if it is a single bit, I'd expect BIT(x)
instead of shifting a one.

Anyway, you are not directly responsible for it.

Sebastian

>
> -#define SYNC_ENABLE_BIT		24
> -#define WR_HIGH_BIT		16
> -#define WR_LOW_BIT		8
> +#define ARMADA_SYNC_ENABLE_BIT		24
> +#define ARMADA_WR_HIGH_BIT		16
> +#define ARMADA_WR_LOW_BIT		8
>
> -#define READ_PARAM_OFFSET	0x0
> -#define WRITE_PARAM_OFFSET	0x4
> +#define ARMADA_READ_PARAM_OFFSET	0x0
> +#define ARMADA_WRITE_PARAM_OFFSET	0x4
>
>   struct devbus_read_params {
>   	u32 bus_width;
> @@ -171,31 +171,31 @@ static int devbus_set_timing_params(struct devbus *devbus,
>   		return err;
>
>   	/* Set read timings */
> -	value = r.bus_width << DEV_WIDTH_BIT |
> -		r.badr_skew << BADR_SKEW_BIT |
> -		r.rd_hold   << RD_HOLD_BIT   |
> -		r.acc_next  << ACC_NEXT_BIT  |
> -		r.rd_setup  << RD_SETUP_BIT  |
> -		r.acc_first << ACC_FIRST_BIT |
> +	value = r.bus_width << ARMADA_DEV_WIDTH_BIT |
> +		r.badr_skew << ARMADA_BADR_SKEW_BIT |
> +		r.rd_hold   << ARMADA_RD_HOLD_BIT   |
> +		r.acc_next  << ARMADA_ACC_NEXT_BIT  |
> +		r.rd_setup  << ARMADA_RD_SETUP_BIT  |
> +		r.acc_first << ARMADA_ACC_FIRST_BIT |
>   		r.turn_off;
>
>   	dev_dbg(devbus->dev, "read parameters register 0x%p = 0x%x\n",
> -		devbus->base + READ_PARAM_OFFSET,
> +		devbus->base + ARMADA_READ_PARAM_OFFSET,
>   		value);
>
> -	writel(value, devbus->base + READ_PARAM_OFFSET);
> +	writel(value, devbus->base + ARMADA_READ_PARAM_OFFSET);
>
>   	/* Set write timings */
> -	value = w.sync_enable  << SYNC_ENABLE_BIT |
> -		w.wr_low       << WR_LOW_BIT      |
> -		w.wr_high      << WR_HIGH_BIT     |
> +	value = w.sync_enable  << ARMADA_SYNC_ENABLE_BIT |
> +		w.wr_low       << ARMADA_WR_LOW_BIT      |
> +		w.wr_high      << ARMADA_WR_HIGH_BIT     |
>   		w.ale_wr;
>
>   	dev_dbg(devbus->dev, "write parameters register: 0x%p = 0x%x\n",
> -		devbus->base + WRITE_PARAM_OFFSET,
> +		devbus->base + ARMADA_WRITE_PARAM_OFFSET,
>   		value);
>
> -	writel(value, devbus->base + WRITE_PARAM_OFFSET);
> +	writel(value, devbus->base + ARMADA_WRITE_PARAM_OFFSET);
>
>   	return 0;
>   }
>
