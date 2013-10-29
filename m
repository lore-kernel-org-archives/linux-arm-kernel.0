From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Oct 2013 11:40:24 -0400
Subject: [PATCHv2 3/7] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <1383023757-30711-4-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
 <1383023757-30711-4-git-send-email-gerg@uclinux.org>
Message-ID: <20131029154024.GC26784@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:15:53PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Add machine support code for the Freescale IMX50 SoC.
> 
> It is very similar to the Freescale IMX53, it contains many of the same
> periperhal hardware modules, at the same address offsets as the IMX53.
> (Notable exceptions are that the IMX50 contains no CAN bus hardware, less
> GPIO, no VPU, it does contain an Electrophoretic display controller though).
> 
> So this support code just uses the IMX53 definitions as they are today.
> We can add the extra IMX50 definitions in the future when required.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/mach-imx/Makefile     |  1 +
>  arch/arm/mach-imx/mach-imx50.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 arch/arm/mach-imx/mach-imx50.c
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index bbe1f5b..924e117 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -112,6 +112,7 @@ obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += mach-cpuimx51sd.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
>  
>  obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
> +obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
>  obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
>  
>  obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
> diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
...
> +static const char *imx50_dt_board_compat[] __initdata = {
> +	"fsl,imx50",
> +	NULL
> +};

Wasn't this going to be consolidated with mach-imx53.c by adding this
compat string to it?

thx,

Jason.
