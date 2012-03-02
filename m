From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Fri, 02 Mar 2012 15:00:04 +0100
Subject: [PATCH v6 1/2] mfd: Add anatop mfd driver
In-Reply-To: <1330671641-6439-1-git-send-email-paul.liu@linaro.org> (Ying-Chun
 Liu's message of "Fri, 2 Mar 2012 15:00:40 +0800")
References: <1330593052-15184-1-git-send-email-paul.liu@linaro.org>
 <1330671641-6439-1-git-send-email-paul.liu@linaro.org>
Message-ID: <87fwdrhzmj.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Y" == Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org> writes:

Hi,

 Y> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
 Y> Anatop is a mfd chip embedded in Freescale i.MX6Q SoC.
 Y> Anatop provides regulators and thermal.
 Y> This driver handles the address space and the operation of the mfd device.

 Y> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
 Y> Cc: Samuel Ortiz <sameo@linux.intel.com>
 Y> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
 Y> Cc: Shawn Guo <shawn.guo@linaro.org>
 Y> ---
 Y>  drivers/mfd/Kconfig        |    6 ++
 Y>  drivers/mfd/Makefile       |    1 +
 Y>  drivers/mfd/anatop-mfd.c   |  142 ++++++++++++++++++++++++++++++++++++++++++++
 Y>  include/linux/mfd/anatop.h |   40 ++++++++++++
 Y>  4 files changed, 189 insertions(+), 0 deletions(-)
 Y>  create mode 100644 drivers/mfd/anatop-mfd.c
 Y>  create mode 100644 include/linux/mfd/anatop.h

 Y> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
 Y> index f147395..f787d17 100644
 Y> --- a/drivers/mfd/Kconfig
 Y> +++ b/drivers/mfd/Kconfig
 Y> @@ -830,6 +830,12 @@ config MFD_INTEL_MSIC
 Y>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
 Y>  	  devices used in Intel Medfield platforms.
 
 Y> +config MFD_ANATOP
 Y> +        bool "Support for Anatop"
 Y> +	depends on SOC_IMX6Q

The bool line should be indented with a <tab>, not spaces.

-- 
Bye, Peter Korsgaard
