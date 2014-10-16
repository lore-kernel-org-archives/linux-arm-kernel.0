From: alvin.chen@intel.com (Chen, Alvin)
Date: Thu, 16 Oct 2014 00:31:41 +0000
Subject: [PATCH 0/2 v3] SPI: spi-pxa2xx: Add support for Intel Quark
 X1000 SPI controller
In-Reply-To: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E999534@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Any update for these patches? Just want to follow-up.


Best regards?Alvin Chen
ICFS Platform Engineering Solution
Flex Services (CMMI Level 3, IQA2005, IQA2008),?Greater Asia Region Intel Information Technology Tel. 010-82171960
inet.8-7581960
Email. alvin.chen at intel.com 

> -----Original Message-----
> From: Chen, Alvin
> Sent: Wednesday, October 8, 2014 11:50 PM
> To: Eric Miao; Russell King; Haojian Zhuang; Mark Brown
> Cc: linux-arm-kernel at lists.infradead.org; linux-spi at vger.kernel.org;
> linux-kernel at vger.kernel.org; Westerberg, Mika; Kweh, Hock Leong; Ong, Boon
> Leong; Tan, Raymond; Chen, Alvin; Andy Shevchenko
> Subject: [PATCH 0/2 v3] SPI: spi-pxa2xx: Add support for Intel Quark X1000 SPI
> controller
> 
> Hi,
> Intel Quark X1000 consists of two SPI controllers which can be PCI enumerated.
> SPI-PXA2XX PCI layer doesn't support it. Thus, we add support for Intel Quark
> X1000 SPI as well.
> 
> ---
> v3:
> [PATCH 1/2]
> * Improve the commit message.
> * A couple of minor fixes.
> [PATCH 2/2]
> * Set '.num_chipselect' to '1' instead of '4'.
> * A couple of minor fixes.
> 
> v2:
>   Split into two patches: one is for helper functions,
>   and another is for quark supporting.
> 
> [PATCH 1/2]
> * Add helper functions to access registers.
> * Use 'switch' instead of 'if-else'.
> [PATCH 2/2]
> * Use 'switch' instead of 'if-else'.
> * Add comments for the 'dds'&'clk_div' caculation.
> * A couple of minor fixes.
> 
> Weike Chen (2):
>   SPI: spi-pxa2xx: Add helpers for regiseters' accessing
>   SPI: spi-pxa2xx: SPI support for Intel Quark X1000
> 
>  drivers/spi/spi-pxa2xx-pci.c |    8 ++
>  drivers/spi/spi-pxa2xx.c     |  304
> ++++++++++++++++++++++++++++++++++++------
>  drivers/spi/spi-pxa2xx.h     |   16 ++-
>  include/linux/pxa2xx_ssp.h   |   21 +++
>  4 files changed, 304 insertions(+), 45 deletions(-)
> 
> --
> 1.7.9.5
