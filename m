From: rdunlap@xenotime.net (Randy Dunlap)
Date: Tue, 8 Mar 2011 09:58:42 -0800
Subject: [Qualcomm PM8921 MFD v2 1/6] mfd: pm8921: Add PMIC 8921 core
	driver
In-Reply-To: <1299564590-30116-2-git-send-email-adharmap@codeaurora.org>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-2-git-send-email-adharmap@codeaurora.org>
Message-ID: <20110308095842.99aa7efb.rdunlap@xenotime.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  7 Mar 2011 22:09:45 -0800 adharmap at codeaurora.org wrote:

> From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> 
> Add support for the Qualcomm PM8921 PMIC chip. The core driver
> will communicate with the PMIC chip via the MSM SSBI bus.
> 
> 
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> ---
>  drivers/mfd/Kconfig             |   18 +++++
>  drivers/mfd/Makefile            |    1 +
>  drivers/mfd/pm8921-core.c       |  157 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/pm8921.h      |   26 +++++++
>  include/linux/mfd/pm8xxx/core.h |   66 ++++++++++++++++
>  5 files changed, 268 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/pm8921-core.c
>  create mode 100644 include/linux/mfd/pm8921.h
>  create mode 100644 include/linux/mfd/pm8xxx/core.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index fd01836..46f0d2f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -624,6 +624,24 @@ config MFD_WL1273_CORE
>  	  driver connects the radio-wl1273 V4L2 module and the wl1273
>  	  audio codec.
>  
> +config MFD_PM8XXX
> +	tristate
> +
> +config MFD_PM8921_CORE
> +	tristate "Qualcomm PM8921 PMIC chip"
> +	depends on MSM_SSBI
> +	select MFD_CORE
> +	select MFD_PM8XXX
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  built-in PM8921 PMIC chip

end sentence with period, please.

> +
> +	  This is required if your board has a PM8921 and uses its features,
> +	  such as: MPPs, GPIOs, regulators, interrupts, and PWM.
> +
> +	  Say M here if you want to include support for PM8921 chip as a module.
> +	  This will build a module called "pm8921-core.ko".

Drop the ".ko".  We (usually) don't spell that out since "modprobe pm8921-core"
works.

> +
>  endif # MFD_SUPPORT
>  
>  menu "Multimedia Capabilities Port drivers"


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
