From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Sep 2010 15:37:20 +0800
Subject: [PATCH 01/11] arch/arm: Remove pr_<level> uses of KERN_<level>
In-Reply-To: <78519236782f0f4a848d67aefb5fe7b3ce375cee.1284267142.git.joe@perches.com>
References: <cover.1284267142.git.joe@perches.com>
	<78519236782f0f4a848d67aefb5fe7b3ce375cee.1284267142.git.joe@perches.com>
Message-ID: <AANLkTinmZbhre05GNcqOh1Sqv+vaN1MqLo4X7dGYuALO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 12, 2010 at 1:10 PM, Joe Perches <joe@perches.com> wrote:
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to 'fix', with a little bit modification to the subject line to follow
ARM patch title conventions.

> ---
> ?arch/arm/mach-pxa/cpufreq-pxa2xx.c | ? ?3 +--
> ?1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> index 50d5939..58093d9 100644
> --- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> +++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> @@ -312,8 +312,7 @@ static int pxa_set_target(struct cpufreq_policy *policy,
> ? ? ? ?freqs.cpu = policy->cpu;
>
> ? ? ? ?if (freq_debug)
> - ? ? ? ? ? ? ? pr_debug(KERN_INFO "Changing CPU frequency to %d Mhz, "
> - ? ? ? ? ? ? ? ? ? ? ? ?"(SDRAM %d Mhz)\n",
> + ? ? ? ? ? ? ? pr_debug("Changing CPU frequency to %d Mhz, (SDRAM %d Mhz)\n",
> ? ? ? ? ? ? ? ? ? ? ? ? freqs.new / 1000, (pxa_freq_settings[idx].div2) ?
> ? ? ? ? ? ? ? ? ? ? ? ? (new_freq_mem / 2000) : (new_freq_mem / 1000));
>
> --
> 1.7.3.rc1
>
>
