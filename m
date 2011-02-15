From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Feb 2011 14:50:09 +0900
Subject: [PATCH v2] ARM: S5PV210: Add GONI board setup for CIF camera
	support
In-Reply-To: <1297445273-3829-1-git-send-email-s.nawrocki@samsung.com>
References: <1297445273-3829-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <008d01cbccd4$3897da00$a9c78e00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Hello,
> 
Hi,

> the following patch series introduces changes in GONI board setup file
> required for the CIF camera sensor driver.
> The first patch adds the I2C0 bus driver, the second one adds the
regulator
> supply definitions and the third one just increases virtual size
> of the framebuffer window 0 to enable double-buffering.
> The added regulator supplies are also a subset of the supplies of the high
> resolution camera which that reference board is equipped with.
> 
> Changes since v1:
>  - removed unnecessary "select CONFIG_S3C_DEV_I2C0"
> 
> 
> The patch series contains:
> 
> [PATCH 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
> [PATCH 2/3] ARM: S5PV210: Add supplies for CIF camera on GONI board
> [PATCH 3/3] ARM: S5PV210: Change framebuffer window 0 size on GONI
> 
> Created against for-next branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> 
Hmm...looks you don't want to follow my suggestion on 2nd patch.

I'm still wondering why array is needed for just one member in
regulator_consumer_supply structure now even though other something will be
added later.

Nevertheless will apply your 3 patches but if not required array will be
removed later.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
