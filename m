From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Feb 2012 16:14:12 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <1329169408-17253-14-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-14-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB4EB3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2012 2:43 PM, Rob Herring wrote:
>
> Add a kconfig option NEED_MACH_IO_H to conditionally include mach/io.h.
>
> Basing this on CONFIG_PCI and CONFIG_ISA doesn't quite work. Most ISA
> platforms don't need mach/io.h, but ebsa110 does. Most PCI platforms need
> mach/io.h for now, but ks8695 doesn't which means it's broken? omap has a
> lot of other stuff in its io.h, so it also needs io.h until it is cleaned
> up.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/Kconfig          |   21 +++++++++++++++++++++
>  arch/arm/include/asm/io.h |    5 +++++
>  2 files changed, 26 insertions(+), 0 deletions(-)

On EP93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
