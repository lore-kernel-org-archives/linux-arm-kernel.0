From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 27 Oct 2016 17:13:13 +0530
Subject: [PATCH v3] ARM: davinci: da8xx: Fix some redefined symbol warnings
In-Reply-To: <1477485542-10555-2-git-send-email-abailon@baylibre.com>
References: <1477485542-10555-1-git-send-email-abailon@baylibre.com>
 <1477485542-10555-2-git-send-email-abailon@baylibre.com>
Message-ID: <7026f012-ffce-cc28-85be-9a5cd26de60f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 October 2016 06:09 PM, Alexandre Bailon wrote:
> Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
> but da8xx-cfgchip.h intend to replace them.
> The usb-da8xx.c is using both headers, causing redefined symbol warnings.

Looks like this is not true for v4.9-rc2 and so I don't see any warnings
in v4.9-rc2. This is probably introduced due to some changes you are
doing for v4.10 and so it is not a v4.9-rc candidate.

> Remove the macro and update the board files to use da8xx-cfgchip.h

This patch should probably be folded into the patch which actually
introduces da8xx-cfgchip.h into usb-da8xx.c

> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Thanks,
Sekhar
