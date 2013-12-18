From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 18 Dec 2013 15:38:19 +0400
Subject: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
Message-ID: <52B1892B.1020806@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-12-2013 1:44, Wolfram Sang wrote:

> From: Wolfram Sang <wsa@sang-engineering.com>

> Tested with RIIC2 on a genmai board. Others untested but hopefully
> trivial enough to be added.

> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> ---
>   arch/arm/mach-shmobile/clock-r7s72100.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
> index 7b457ae..770316d 100644
> --- a/arch/arm/mach-shmobile/clock-r7s72100.c
> +++ b/arch/arm/mach-shmobile/clock-r7s72100.c
[...]
> @@ -173,6 +179,10 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
>
>   	/* ICK */
> +	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
> +	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
> +	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
> +	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),

    These belong to some other place, the group marked by /* ICK */ is only 
for CLKDEV_ICK_ID().

>   	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP47]),
>   	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP46]),
>   	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP45]),

WBR, Sergei
