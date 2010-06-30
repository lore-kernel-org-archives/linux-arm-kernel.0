From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 30 Jun 2010 18:24:20 +0200
Subject: [PATCH 30/33] Removing dead S3C_DEV_ADC
In-Reply-To: <7baaebb4983ce9482e3f83ca42240b864157cb79.1277911346.git.siccegge@cs.fau.de>
	(Christoph Egger's message of "Wed\,
	30 Jun 2010 18\:03\:26 +0200")
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<7baaebb4983ce9482e3f83ca42240b864157cb79.1277911346.git.siccegge@cs.fau.de>
Message-ID: <876310pjyj.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph Egger <siccegge@cs.fau.de> writes:

> S3C_DEV_ADC doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-s5pv210/cpu.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index 411a4a9..c5d53ab 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -76,10 +76,6 @@ static void s5pv210_idle(void)
>  
>  void __init s5pv210_map_io(void)
>  {
> -#ifdef CONFIG_S3C_DEV_ADC
> -	s3c_device_adc.name	= "s3c64xx-adc";
> -#endif
> -

too bad, should have been SAMSUNG_DEV_ADC :(
Anyway, a patch called "[PATCH] ARM: SAMSUNG: Implement set_name
function for ADC devices" has been sent for review today and is
addressing this same issue.

Thanks,
Arnaud
