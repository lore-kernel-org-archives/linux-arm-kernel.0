From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Apr 2016 08:28:49 +0100
Subject: [RESEND 00/11] pwm: Add support for PWM Capture
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412072849.GH8094@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Mar 2016, Lee Jones wrote:

> The first part of this set extends the current PWM API to allow external
> code to request a PWM Capture.  Subsequent patches then make use of the
> new API by providing a userspace offering via /sysfs.  The final part of
> the set supplies PWM Capture functionality into the already existing STi
> PWM driver.
>  
> This patch-set has been tested end to end via /sysfs.

Hopefully you still have this set in your inbox.

Please let me know if you wish me to resend it.

> Lee Jones (11):
>   pwm: Add PWM Capture support
>   pwm: sysfs: Add PWM Capture support
>   pwm: sti: Reorganise register names in preparation for new
>     functionality
>   pwm: sti: Only request clock rate when you need to
>   pwm: sti: Supply PWM Capture register addresses and bit locations
>   pwm: sti: Supply PWM Capture clock handling
>   pwm: sti: Initialise PWM Capture channel data
>   pwm: sti: Add support for PWM Capture IRQs
>   pwm: sti: Add PWM Capture call-back
>   pwm: sti: Enable PWM Capture
>   pwm: sti: Take the opportunity to conduct a little house keeping
> 
>  drivers/pwm/core.c    |  26 ++++
>  drivers/pwm/pwm-sti.c | 384 ++++++++++++++++++++++++++++++++++++++++++--------
>  drivers/pwm/sysfs.c   |  28 ++++
>  include/linux/pwm.h   |  13 ++
>  4 files changed, 392 insertions(+), 59 deletions(-)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
