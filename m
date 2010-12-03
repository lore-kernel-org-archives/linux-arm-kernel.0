From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 3 Dec 2010 14:14:27 +0900
Subject: [PATCH 3/4] plat-s5p: Add platform support for MIPI-CSI2 devices
In-Reply-To: <1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
Message-ID: <AANLkTimgazoKTyuG37oUbD_45Cv7Un4=GDMsXXxCuH5U@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 3, 2010 at 1:37 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> There may be up to 2 MIPI-CSI2 interfaces depending on SoC version.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? | ? 10 ++++++++
> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ?| ? ?2 +
> ?arch/arm/plat-s5p/dev-csis0.c ? ? ? ? ? ? | ? 34 +++++++++++++++++++++++++++++
> ?arch/arm/plat-s5p/dev-csis1.c ? ? ? ? ? ? | ? 33 ++++++++++++++++++++++++++++
> ?arch/arm/plat-samsung/include/plat/csis.h | ? 28 +++++++++++++++++++++++
> ?arch/arm/plat-samsung/include/plat/devs.h | ? ?3 ++
> ?6 files changed, 110 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/plat-s5p/dev-csis0.c
> ?create mode 100644 arch/arm/plat-s5p/dev-csis1.c
> ?create mode 100644 arch/arm/plat-samsung/include/plat/csis.h
>
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 65dbfa8..2fb0c88 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -56,3 +56,13 @@ config S5P_DEV_ONENAND
> ? ? ? ?bool
> ? ? ? ?help
> ? ? ? ? ?Compile in platform device definition for OneNAND controller
> +
> +config S5P_DEV_CSIS0
> + ? ? ? bool
> + ? ? ? help
> + ? ? ? ? Compile in platform device definitions for MIPI-CSI2 interface 0
> +
> +config S5P_DEV_CSIS1
> + ? ? ? bool
> + ? ? ? help
> + ? ? ? ? Compile in platform device definitions for MIPI-CSI2 interface 1
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index de65238..2b73173 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -28,3 +28,5 @@ obj-$(CONFIG_S5P_DEV_FIMC0) ? += dev-fimc0.o
> ?obj-$(CONFIG_S5P_DEV_FIMC1) ? ?+= dev-fimc1.o
> ?obj-$(CONFIG_S5P_DEV_FIMC2) ? ?+= dev-fimc2.o
> ?obj-$(CONFIG_S5P_DEV_ONENAND) ?+= dev-onenand.o
> +obj-$(CONFIG_S5P_DEV_CSIS0) ? ?+= dev-csis0.o
> +obj-$(CONFIG_S5P_DEV_CSIS1) ? ?+= dev-csis1.o

When we do have defines for each device, why not have both in one file
with each contained in ifdef for it's define ? That will reduce file count.
