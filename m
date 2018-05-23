From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 23 May 2018 07:24:14 +0000
Subject: [PATCH v2] rtc: st-lpc: add range
In-Reply-To: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
References: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
Message-ID: <8d2f6057-4d33-6b75-f01e-df06e9426d07@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre

On 05/21/2018 10:49 PM, Alexandre Belloni wrote:
> The RTC has a 64 bit counter.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-st-lpc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index 2f1ef2c28740..bee75ca7ff79 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -258,6 +258,8 @@ static int st_rtc_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, rtc);
>   
>   	rtc->rtc_dev->ops = &st_rtc_ops;
> +	rtc->rtc_dev->range_max = U64_MAX;
> +	do_div(rtc->rtc_dev->range_max, rtc->clkrate);
>   
>   	ret = rtc_register_device(rtc->rtc_dev);
>   	if (ret) {
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Patrice
