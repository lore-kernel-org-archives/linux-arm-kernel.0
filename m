From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Jun 2015 21:31:41 +0200 (CEST)
Subject: [RFC PATCH v6 2/2] nvmem: Add Vybrid OCOTP and OCROM support
In-Reply-To: <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
References: <cover.1435066190.git.maitysanchayan@gmail.com>
 <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
Message-ID: <1037424954.250728.1435087901102.JavaMail.open-xchange@oxbsltgw00.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanchayan,

> Sanchayan Maity <maitysanchayan@gmail.com> hat am 23. Juni 2015 um 15:44
> geschrieben:
>
>
> The patch adds support for the On Chip One Time Programmable Peripheral
> (OCOTP) and On Chip ROM (OCROM) support.
>
> On Vybrid OCOTP contain data like SoC ID, MAC address and OCROM has the
> revision ID.
>
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
> drivers/nvmem/Kconfig | 11 +++++++++
> drivers/nvmem/Makefile | 2 ++
> drivers/nvmem/vf610-ocotp.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 73 insertions(+)
> create mode 100644 drivers/nvmem/vf610-ocotp.c
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 17f1a57..557c1e0 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -33,4 +33,15 @@ config NVMEM_SUNXI_SID
> This driver can also be built as a module. If so, the module
> will be called eeprom-sunxi-sid.
>
> +config NVMEM_VF610_OCOTP
> + tristate "VF610 SoCs OCOTP support"
> + depends on SOC_VF610
> + select REGMAP_MMIO

how do you come to the conclusion that Vybrid On-Chip OTP is accessable via
MMIO?

Regards
Stefan
