From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 12:35:42 -0800
Subject: [PATCH 4/5] ARM: Tegra: Create defines for GPIO names
In-Reply-To: <AANLkTinPssv8Wpy0Qe5GAHqN=9dicSLZ8sUmq+JeW2_q@mail.gmail.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-5-git-send-email-swarren@nvidia.com>
	<AANLkTinPssv8Wpy0Qe5GAHqN=9dicSLZ8sUmq+JeW2_q@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5D59@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Wednesday, February 23, 2011 12:09 PM:
> On Wed, Feb 23, 2011 at 10:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > This ensures they're kept in sync between platform_data definitions and
> > the GPIO table initialization.
>
> Can you name these for what they are used for (if they have a single use)?
> i.e. TEGRA_GPIO_EMMC_CD instead of TEGRA_GPIO_SD2_CD

Are you looking for correlation with the schematics, or something else;
my interpretation is that the names in the patch already appear to describe
what the signals are used for.

In particular, in your example, you wrote "EMMC" rather than "SD2". I'm not
sure where the name "EMMC" comes from, nor why there's no number in the name
"EMMC".

For reference, the schematics for these two boards use the following signal
names:

Harmony:
SDIO2_CD, SDIO2_WP, EN_VDDIO_SD
HSMMC_CD, HSMMC_WP, EN_VDDIO_SDMMC

Seaboard:
SDIO32_CD, SDIO3_WP, EN_VDDIO_SD

Would those be OK?

Thanks.

-- 
nvpublic
