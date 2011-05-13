From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 13 May 2011 15:43:54 +0400
Subject: [PATCH] ARM: S5PV210: Fix possible null pointer dereference.
In-Reply-To: <1305270186-7722-1-git-send-email-kgene.kim@samsung.com>
References: <1305270186-7722-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4DCD197A.9020900@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-05-2011 11:03, Kukjin Kim wrote:

> From: Jonghwan Choi<jhbird.choi@samsung.com>

> Signed-off-by: Jonghwan Choi<jhbird.choi@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
>   arch/arm/mach-s5pv210/cpufreq.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-s5pv210/cpufreq.c b/arch/arm/mach-s5pv210/cpufreq.c
> index 22046e2..58340ee 100644
> --- a/arch/arm/mach-s5pv210/cpufreq.c
> +++ b/arch/arm/mach-s5pv210/cpufreq.c
> @@ -105,8 +105,10 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
>   		reg = (S5P_VA_DMC0 + 0x30);
>   	else if (ch == DMC1)
>   		reg = (S5P_VA_DMC1 + 0x30);
> -	else
> +	else {
>   		printk(KERN_ERR "Cannot find DMC port\n");
> +		return;
> +	}

    According to CodingStyle, other branches should now have {} too.

WBR, Sergei
