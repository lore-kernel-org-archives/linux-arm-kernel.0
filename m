From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Oct 2010 18:03:52 +0900
Subject: [PATCH RFC/RFT] ARM: S5P: Fix USB and 48M clock enable procedure
In-Reply-To: <20101012194021.11514.12704.stgit@localhost.localdomain>
References: <20101012194021.11514.12704.stgit@localhost.localdomain>
Message-ID: <008001cb6b7e$ba952920$2fbf7b60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paulius Zaleckas wrote:
> 
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---
> 
>  arch/arm/mach-s5p6440/clock.c              |   23 -------
>  arch/arm/plat-s5p/clock.c                  |   86
> ++++++++++++++++++++++++++++
>  arch/arm/plat-s5p/include/plat/s5p-clock.h |    1
>  3 files changed, 86 insertions(+), 24 deletions(-)
> 
Hi Paulius,

There are some comments about your patches which includes previous S3C64XX patches.

Basically your approach looks good trial and structure...but I'm not sure whether your approach can be used commonly on Samsung's all SoCs or not.
Need to do more test on boards and I already informed your patches to USB engineers in my team, actually need to discuss about this.

As a note, I know, 'xusbxti' clock is structure for external xtal which is used for generating USB clock on board... it depends on board condition, because can be used 12/24/48Mhz on board. The clk_48m means generated actual USB clock, 48Mhz. So should be implemented enable function by using clk_48m...

Anyway let you know about the result of internal discussion soon, then let's talk.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
