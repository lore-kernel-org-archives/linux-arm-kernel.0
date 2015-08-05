From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 05 Aug 2015 14:21:26 +0530
Subject: [PATCH-v5 5/5] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
In-Reply-To: <1437482466-16126-6-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437482466-16126-6-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <55C1CE8E.9000601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 July 2015 06:11 PM, Vaibhav Hiremath wrote:
> With addition of PXA910 family of devices, the TWSI module supports
> SCL clock adjustment using ILCR register.
>
> This patch enables the control and configuration of ICLR through DT
> properties,
>
> i2c-sclk-high-time-ns:
>    SCLK high time (tHigh), for standard/fast/high speed mode
> i2c-sclk-low-time-ns:
>    SCLK low time (tLow), for standard/fast/high speed mode
>
> Note that in case of standard and fast mod, the tLow and tHigh counters
> are same, and software will use tLow value.
>
> Also, brought up devm_clk_get() fn above i2c_pxa_probe_dt(), as it
> uses clk rate for timing calculations.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> Signed-off-by: Yi Zhang <yizhang@marvell.com>
> ---
>   drivers/i2c/busses/i2c-pxa.c | 69 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 6 deletions(-)
>

Robert,

It would be helpful if you can test this patch-series and confirm that
it now fixes the NULL pointer deference issue.

Thanks,
Vaibhav
