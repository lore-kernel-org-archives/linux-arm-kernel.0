From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 Mar 2012 07:34:27 -0800
Subject: [PATCH V6 1/5] ARM: exynos: Add support AFTR mode on EXYNOS4210
In-Reply-To: <CAK44p22LOnJx=bZRfdzAHt7X_snhJGrNoBuXOfsgwBHLLuUziA@mail.gmail.com>
References: <1329805190-8874-1-git-send-email-amit.kachhap@linaro.org>	<1329805190-8874-2-git-send-email-amit.kachhap@linaro.org>	<CAMXH7KHTgzY7XZ=4rOxsu-Ra8SRTOsCg=YWOLBD1QDTskRbygw@mail.gmail.com>
 <CAK44p22LOnJx=bZRfdzAHt7X_snhJGrNoBuXOfsgwBHLLuUziA@mail.gmail.com>
Message-ID: <4F5A2303.7040403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/12 03:49, Amit Kachhap wrote:
> On 23 February 2012 11:54, Rob Lee<rob.lee@linaro.org>  wrote:

[...]

> Hi Mr kim,
>
> Can this change be accommodated in the current patch series as below
> or should i send a new patchset?
>
I did, Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -41,7 +41,7 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>                                  struct cpuidle_driver *drv,
>                                  int index);
>
> -static struct cpuidle_state exynos4_cpuidle_set[] = {
> +static struct cpuidle_state exynos4_cpuidle_set[] __initdata = {
>          [0] = {
>                  .enter                  = exynos4_enter_idle,
>                  .exit_latency           = 1,
>
>
