From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 17:27:45 +0530
Subject: [PATCH v2] ARM: davinci: da8xx: Fix some redefined symbol warnings
In-Reply-To: <1477397492-7925-2-git-send-email-abailon@baylibre.com>
References: <1477397492-7925-1-git-send-email-abailon@baylibre.com>
 <1477397492-7925-2-git-send-email-abailon@baylibre.com>
Message-ID: <3dc1c2c2-c4c5-07d0-3d3e-b8d917adda81@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 October 2016 05:41 PM, Alexandre Bailon wrote:
> Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
> but da8xx-cfgchip.h intend to replace them.
> The usb-da8xx.c is using both headers, causing redefined symbol warnings.
> Remove the macro and update the da830-evm board file to use da8xx-cfgchip.h
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

This leads to build error on v4.9-rc2:

arch/arm/mach-davinci/board-da830-evm.c: In function 'da830_evm_usb_init':
arch/arm/mach-davinci/board-da830-evm.c:120:15: error: 'CFGCHIP2_REFFREQ' undeclared (first use in this function)
  cfgchip2 &= ~CFGCHIP2_REFFREQ;

Thanks,
Sekhar
