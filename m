From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 3 Feb 2012 08:52:54 +0800
Subject: [PATCH v2 2/2] ARM: mx3: Let mx31 and mx35 enter in LPM mode in
 WFI
In-Reply-To: <1328220152-3037-2-git-send-email-festevam@gmail.com>
References: <1328220152-3037-1-git-send-email-festevam@gmail.com>
 <1328220152-3037-2-git-send-email-festevam@gmail.com>
Message-ID: <20120203005253.GD32403@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index 8404ee7..5f66791 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -34,6 +34,7 @@ static void imx3_idle(void)
>  {
>  	unsigned long reg = 0;
>  
> +	mx3_cpu_lp_set(MX3_WAIT);
Isn't it supposed to use cpuidle to level the idle state?

Thanks
Richard
