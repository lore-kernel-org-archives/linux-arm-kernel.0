From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 23 Jul 2018 15:21:46 -0700
Subject: [PATCH v7 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
In-Reply-To: <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
Message-ID: <c1abe3ec-fc26-d8b0-c769-e9295577ac05@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2018 02:47 PM, Jae Hyun Yoo wrote:
> This commit adds PECI client MFD driver.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> ---
>  drivers/mfd/Kconfig                   |  14 ++
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/intel-peci-client.c       | 182 ++++++++++++++++++++++++++
>  include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
>  4 files changed, 278 insertions(+)
>  create mode 100644 drivers/mfd/intel-peci-client.c
>  create mode 100644 include/linux/mfd/intel-peci-client.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f3fa516011ec..e38b591479d4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>  	  devices used in Intel Medfield platforms.
>  
> +config MFD_INTEL_PECI_CLIENT
> +	bool "Intel PECI client"
> +	depends on (PECI || COMPILE_TEST)
> +	select MFD_CORE
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  multi-funtional Intel PECI (Platform Environment Control Interface)

	  multi-functional

> +	  client. PECI is a one-wire bus interface that provides a communication
> +	  channel from PECI clients in Intel processors and chipset components
> +	  to external monitoring or control devices.
> +
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600


-- 
~Randy
