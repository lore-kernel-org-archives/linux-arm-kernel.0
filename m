From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 09:30:59 +0100
Subject: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
In-Reply-To: <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
 <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
Message-ID: <CAORVsuX3nJAgbDY+oNQ+OD6xeZt=OkhK4n769Y+xJb0NXcrBmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Feb 29, 2012 at 4:11 AM, Robert Lee <rob.lee@linaro.org> wrote:
> Make necessary changes to implement time keeping and irq enabling
> in the core cpuidle code. ?This will allow the removal of these
> functionalities from various platform cpuidle implementations whose
> timekeeping and irq enabling follows the form in this common code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> ?arch/arm/include/asm/cpuidle.h | ? 14 ++++++
> ?drivers/cpuidle/cpuidle.c ? ? ?| ? 90 ++++++++++++++++++++++++++++++++--------
> ?include/linux/cpuidle.h ? ? ? ?| ? 13 ++++++
> ?3 files changed, 99 insertions(+), 18 deletions(-)
> ?create mode 100644 arch/arm/include/asm/cpuidle.h
>
...

> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 59f4261..00b02f5 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
...

> @@ -110,7 +126,8 @@ int cpuidle_idle_call(void)
> ? ? ? ? ? ? ? ?dev->states_usage[entered_state].time +=
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(unsigned long long)dev->last_residency;
> ? ? ? ? ? ? ? ?dev->states_usage[entered_state].usage++;
> - ? ? ? }
> + ? ? ? } else
> + ? ? ? ? ? ? ? dev->last_residency = 0;
Braces are required here, according to the coding style doc.

...

Regards,
Jean
