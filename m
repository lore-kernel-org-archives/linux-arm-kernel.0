From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jan 2011 22:43:48 +0000
Subject: [PATCH] ARM: vexpress: register platform PATA device.
In-Reply-To: <1294435445-2020-1-git-send-email-nbowler@elliptictech.com>
References: <1294435445-2020-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <20110107224348.GZ31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 04:24:05PM -0500, Nick Bowler wrote:
> The compactflash device on this platform is not usable simply because it
> is never registered with the kernel.  Fix that up.
> 
> Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
> ---
>  arch/arm/Kconfig             |    1 +
>  arch/arm/mach-vexpress/v2m.c |   25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d56d21c..ee61039 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -264,6 +264,7 @@ config ARCH_VEXPRESS
>  	select HAVE_CLK
>  	select ICST
>  	select PLAT_VERSATILE
> +	select HAVE_PATA_PLATFORM

To avoid the Kconfig warning, this should be:

	select HAVE_PATA_PLATFORM if ATA

or it needs to be moved outside of the if ATA ... endif block in
drivers/ata/Kconfig.

Apart from that, I see nothing wrong.
