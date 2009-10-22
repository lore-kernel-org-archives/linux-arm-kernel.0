From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 22 Oct 2009 18:02:12 +0400
Subject: [PATCH 43/46] DaVinci: remove unneeded #include's
In-Reply-To: <1255720190-7452-45-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-41-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-42-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-43-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-44-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-45-git-send-email-khilman@deeprootsystems.com>
Message-ID: <4AE065E4.70506@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Kevin Hilman wrote:

> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> There have accumulated quite a lot of them after the code reorganizations...

> In several cases I had to replace #include <linux/dma-mapping.h> which wasn't
> needed directly but happened to #include <linux/err.h> which was needed.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

[...]

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index b804d57..120ede0 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -11,24 +11,21 @@
>   * is licensed "as is" without any warranty of any kind, whether express
>   * or implied.
>   */
> -#include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/clk.h>
> -#include <linux/platform_device.h>
>  #include <linux/cpufreq.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <asm/mach/map.h>
>  
> -#include <mach/clock.h>
>  #include <mach/psc.h>
> -#include <mach/mux.h>
>  #include <mach/irqs.h>
>  #include <mach/cputype.h>
>  #include <mach/common.h>
>  #include <mach/time.h>
>  #include <mach/da8xx.h>
>  #include <mach/cpufreq.h>
> +#include <linux/platform_device.h>

    As has been pointed out, this is not in its proper group. Perhaps the 
patch can be changed before pushing upstream, and removal and addition of 
this line just nullified?

WBR, Sergei
