From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 15:46:01 +0100
Subject: [PATCH] arm: Add VIRTUALIZATION configuration menu and virtio
	options
In-Reply-To: <1317224886-3925-1-git-send-email-pawel.moll@arm.com>
References: <1317224886-3925-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20111006144601.GE26349@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 04:48:06PM +0100, Pawel Moll wrote:
> This patch adds menuconfig VIRTUALIZATION to arm Kconfig
> and includes virtio Kconfig in it.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/Kconfig |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3269576..426f330 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2101,4 +2101,20 @@ source "security/Kconfig"
>  
>  source "crypto/Kconfig"
>  
> +menuconfig VIRTUALIZATION
> +	bool "Virtualization"
> +	default n

Please resubmit without the line above.  default n is default's default
default, so it's completely redundant by default.
