From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Feb 2011 21:43:03 +0300
Subject: [PATCH v2 03/13] da850: pruss board specific additions.
In-Reply-To: <1297435892-28278-4-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-4-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D558337.2060401@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subhasish Ghosh wrote:

> This patch adds board specific initializations and setup routines.

> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 11f986b..242d1ed 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1053,6 +1053,26 @@ static __init int da850_evm_init_cpufreq(void)
>  static __init int da850_evm_init_cpufreq(void) { return 0; }
>  #endif
>  
> +static struct da8xx_pruss_devices pruss_devices[] = {
> +	{.dev_name = NULL,},

    No need to explicitly initialize to NULL.

WBR, Sergei
