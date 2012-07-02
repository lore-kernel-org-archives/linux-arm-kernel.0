From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 2 Jul 2012 17:14:37 +0200
Subject: [PATCH 04/15] mfd: ab8500: Register devices using the newly
 DT:ed MFD API
In-Reply-To: <4FF17202.9080106@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-5-git-send-email-lee.jones@linaro.org>
 <20120629150924.GG22806@sortiz-mobl> <4FEDD212.4020209@linaro.org>
 <20120629185047.GY22806@sortiz-mobl> <4FF17202.9080106@linaro.org>
Message-ID: <20120702151437.GO22065@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Jul 02, 2012 at 11:03:46AM +0100, Lee Jones wrote:
> >>> This one does not apply properly against my for-next branch. Could you please
> >>> generate a new one for me ?
> >>
> >> Hmm... we have a problem.
> >>
> >> I have the new patch based on -next, but I can't test it, as -next
> >> is broken for Snowball. Hence why I'm still using rc2. Do you want
> >> it anyway?
> > Yes. And once Snowball is working with -next, I'll take a patch fix from you
> > if necessary.
> 
> Okay, this one applies on -next:
> 
> From: Lee Jones <lee.jones@linaro.org>
> Date: Wed, 20 Jun 2012 08:48:33 +0100
> Subject: [PATCH 1/1] mfd: ab8500: Register devices using the newly DT:ed MFD
>  API
> 
> Now the MFD API is Device Tree aware we can use it for platform
> registration again, even when booting with DT enabled. To aid in
> Device Node pointer allocation we provide each cell with the
> associative compatible string.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c |    1 -
>  drivers/mfd/ab8500-core.c          |   64 ++++++++++++++++++++++--------------
>  drivers/mfd/ab8500-debugfs.c       |    6 ----
>  drivers/mfd/ab8500-gpadc.c         |    6 ----
>  drivers/mfd/ab8500-sysctrl.c       |    6 ----
>  drivers/misc/ab8500-pwm.c          |    6 ----
>  drivers/regulator/ab8500.c         |    6 ----
>  drivers/rtc/rtc-ab8500.c           |    7 ----
>  drivers/usb/otg/ab8500-usb.c       |    6 ----
>  9 files changed, 39 insertions(+), 69 deletions(-)
Applied, although rtc-ab8500.c and ab8500-usb.c did not need any changes.
Please check commit 47e1f40fcb12f976e7769f75c04c65828ed5da75 on my for-next
branch to see if I missed anything.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
