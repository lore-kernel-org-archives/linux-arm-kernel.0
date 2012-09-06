From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 6 Sep 2012 15:33:18 -0700
Subject: [PATCH 05/12] ARM: socfpga: move debug macros to include/debug
In-Reply-To: <1346962375-26163-6-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-6-git-send-email-robherring2@gmail.com>
Message-ID: <71B37E0559AC6849A68C5BA94C509FB45A04C4CDD3@SJ-ITMSG02.altera.priv.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, 2012-09-06 at 15:12 -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Move socfpga debug-macro.S over to common debug macro directory.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> ---
>  arch/arm/Kconfig.debug                             |    8 ++++++++
>  .../mach/debug-macro.S => include/debug/socfpga.S} |    0
>  2 files changed, 8 insertions(+)
>  rename arch/arm/{mach-socfpga/include/mach/debug-macro.S => include/debug/socfpga.S} (100%)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 3bafdd2..aa56934 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -317,6 +317,13 @@ choice
>                 The uncompressor code port configuration is now handled
>                 by CONFIG_S3C_LOWLEVEL_UART_PORT.
>
> +     config DEBUG_SOCFPGA_UART
> +             depends on ARCH_SOCFPGA
> +             bool "Use SOCFPGA UART for low-level debug"
> +             help
> +               Say Y here if you want kernel low-level debugging support
> +               on SOCFPGA based platforms.
> +
>       config DEBUG_VEXPRESS_UART0_DETECT
>               bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
>               depends on ARCH_VEXPRESS && CPU_CP15_MMU
> @@ -385,6 +392,7 @@ config DEBUG_LL_INCLUDE
>       default "debug/icedcc.S" if DEBUG_ICEDCC
>       default "debug/highbank.S" if DEBUG_HIGHBANK_UART
>       default "debug/mvebu.S" if DEBUG_MVEBU_UART
> +     default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
>       default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
>               DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
>       default "mach/debug-macro.S"
> diff --git a/arch/arm/mach-socfpga/include/mach/debug-macro.S b/arch/arm/include/debug/socfpga.S
> similarity index 100%
> rename from arch/arm/mach-socfpga/include/mach/debug-macro.S
> rename to arch/arm/include/debug/socfpga.S

Looks great!

Acked-by: Dinh Nguyen <dinguyen@altera.com>

Confidentiality Notice.
This message may contain information that is confidential or otherwise protected from disclosure. If you are not the intended recipient, you are hereby notified that any use, disclosure, dissemination, distribution,  or copying  of this message, or any attachments, is strictly prohibited.  If you have received this message in error, please advise the sender by reply e-mail, and delete the message and any attachments.  Thank you.
