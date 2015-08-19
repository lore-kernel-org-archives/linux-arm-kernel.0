From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 19 Aug 2015 12:55:05 +0200
Subject: [PATCH V3] Watchdog: Fix parent of watchdog_devices
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Message-ID: <55D46089.8030801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 08/19/2015 05:28 AM, Pratyush Anand wrote:
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index 6785afdc0fca..14e9badf2bfa 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -241,6 +241,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
> +	st_wdog_dev.parent = &pdev->dev;
>   
>   	ret = clk_prepare_enable(clk);
>   	if (ret) {

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
