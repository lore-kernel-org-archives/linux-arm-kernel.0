From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:17:58 +0200
Subject: [PATCH v2 06/38] memory: mvebu-devbus: use _SHIFT suffixes instead
 of _BIT
In-Reply-To: <1398202002-28530-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A166.5050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> As noted by Sebastian Hesselbarth, the definitions in mvebu-devbus.c
> are not bit definition, but rather shift values, so a _SHIFT prefix
> would make more sense. This commit therefore replaces the *_BIT
> definitions by *_SHIFT definitions.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   drivers/memory/mvebu-devbus.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
> index e66de7f..0f196b3 100644
> --- a/drivers/memory/mvebu-devbus.c
> +++ b/drivers/memory/mvebu-devbus.c
> @@ -30,16 +30,16 @@
>   #include <linux/platform_device.h>
>
>   /* Register definitions */
> -#define ARMADA_DEV_WIDTH_BIT		30
> -#define ARMADA_BADR_SKEW_BIT		28
> -#define ARMADA_RD_HOLD_BIT		23
> -#define ARMADA_ACC_NEXT_BIT		17
> -#define ARMADA_RD_SETUP_BIT		12
> -#define ARMADA_ACC_FIRST_BIT		6
> +#define ARMADA_DEV_WIDTH_SHIFT		30
> +#define ARMADA_BADR_SKEW_SHIFT		28
> +#define ARMADA_RD_HOLD_SHIFT		23
> +#define ARMADA_ACC_NEXT_SHIFT		17
> +#define ARMADA_RD_SETUP_SHIFT		12
> +#define ARMADA_ACC_FIRST_SHIFT		6
>
> -#define ARMADA_SYNC_ENABLE_BIT		24
> -#define ARMADA_WR_HIGH_BIT		16
> -#define ARMADA_WR_LOW_BIT		8
> +#define ARMADA_SYNC_ENABLE_SHIFT	24
> +#define ARMADA_WR_HIGH_SHIFT		16
> +#define ARMADA_WR_LOW_SHIFT		8
>
>   #define ARMADA_READ_PARAM_OFFSET	0x0
>   #define ARMADA_WRITE_PARAM_OFFSET	0x4
> @@ -178,12 +178,12 @@ static int devbus_set_timing_params(struct devbus *devbus,
>   		return err;
>
>   	/* Set read timings */
> -	value = r.bus_width << ARMADA_DEV_WIDTH_BIT |
> -		r.badr_skew << ARMADA_BADR_SKEW_BIT |
> -		r.rd_hold   << ARMADA_RD_HOLD_BIT   |
> -		r.acc_next  << ARMADA_ACC_NEXT_BIT  |
> -		r.rd_setup  << ARMADA_RD_SETUP_BIT  |
> -		r.acc_first << ARMADA_ACC_FIRST_BIT |
> +	value = r.bus_width << ARMADA_DEV_WIDTH_SHIFT |
> +		r.badr_skew << ARMADA_BADR_SKEW_SHIFT |
> +		r.rd_hold   << ARMADA_RD_HOLD_SHIFT   |
> +		r.acc_next  << ARMADA_ACC_NEXT_SHIFT  |
> +		r.rd_setup  << ARMADA_RD_SETUP_SHIFT  |
> +		r.acc_first << ARMADA_ACC_FIRST_SHIFT |
>   		r.turn_off;
>
>   	dev_dbg(devbus->dev, "read parameters register 0x%p = 0x%x\n",
> @@ -193,9 +193,9 @@ static int devbus_set_timing_params(struct devbus *devbus,
>   	writel(value, devbus->base + ARMADA_READ_PARAM_OFFSET);
>
>   	/* Set write timings */
> -	value = w.sync_enable  << ARMADA_SYNC_ENABLE_BIT |
> -		w.wr_low       << ARMADA_WR_LOW_BIT      |
> -		w.wr_high      << ARMADA_WR_HIGH_BIT     |
> +	value = w.sync_enable  << ARMADA_SYNC_ENABLE_SHIFT |
> +		w.wr_low       << ARMADA_WR_LOW_SHIFT      |
> +		w.wr_high      << ARMADA_WR_HIGH_SHIFT     |
>   		w.ale_wr;
>
>   	dev_dbg(devbus->dev, "write parameters register: 0x%p = 0x%x\n",
>
