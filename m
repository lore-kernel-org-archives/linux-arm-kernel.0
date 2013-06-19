From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 19 Jun 2013 13:25:31 -0400
Subject: [PATCH 08/15] thermal: cpu_cooling: fix stub function
In-Reply-To: <1370038972-2318779-9-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-9-git-send-email-arnd@arndb.de>
Message-ID: <51C1E98B.8030503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 31-05-2013 18:22, Arnd Bergmann wrote:
> The function stub for cpufreq_cooling_get_level introduced
> in 57df81069 "Thermal: exynos: fix cooling state translation"
> is not syntactically correct C and needs to be fixed to avoid
> this error:
> 
> In file included from drivers/thermal/db8500_thermal.c:20:0:
>  include/linux/cpu_cooling.h: In function 'cpufreq_cooling_get_level':
> include/linux/cpu_cooling.h:57:1:
>  error: parameter name omitted  unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int)  ^
>  include/linux/cpu_cooling.h:57:1: error: parameter name omitted
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>


What is the status of this patch?

I believe Rui is supposed to queue this one right?


> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Amit Daniel kachhap <amit.daniel@samsung.com>
> ---
>  include/linux/cpu_cooling.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 282e270..a5d52ee 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -41,7 +41,7 @@ cpufreq_cooling_register(const struct cpumask *clip_cpus);
>   */
>  void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
>  
> -unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int);
> +unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq);
>  #else /* !CONFIG_CPU_THERMAL */
>  static inline struct thermal_cooling_device *
>  cpufreq_cooling_register(const struct cpumask *clip_cpus)
> @@ -54,7 +54,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  	return;
>  }
>  static inline
> -unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int)
> +unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
>  {
>  	return THERMAL_CSTATE_INVALID;
>  }
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/bf87a86a/attachment.sig>
