From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Jun 2013 19:30:14 +0200
Subject: [PATCH 01/10] ARM: fix ARCH_IXP4xx usage of
 ARCH_SUPPORTS_BIG_ENDIAN
In-Reply-To: <1371645406-16873-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
 <1371645406-16873-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130619193014.51b5c796@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Wed, 19 Jun 2013 13:36:37 +0100, Ben Dooks wrote:
> The Kconfig for arch/arm/mach-ixp4xx has a local definition
> of ARCH_SUPPORTS_BIG_ENDIAN which could be used elsewhere.
> This means that if IXP4xx is selected and this symbol is
> selected eleswhere then an warning is produced.
> 
> Clean the following error up by making the symbol be
> selected by the main ARCH_IXP4XX definition and have a
> common definition in arch/arm/mm/Kconfig
> 
> warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
> warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
> ---
>  arch/arm/Kconfig             |    1 +
>  arch/arm/mach-ixp4xx/Kconfig |    4 ----
>  arch/arm/mm/Kconfig          |    6 ++++++
>  3 files changed, 7 insertions(+), 4 deletions(-)

Patch lacks SoB.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
