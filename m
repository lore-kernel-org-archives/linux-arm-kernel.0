From: marex@denx.de (Marek Vasut)
Date: Wed, 23 Oct 2013 07:04:58 +0200
Subject: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
In-Reply-To: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
Message-ID: <201310230704.58605.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Tim Harvey,

> The IMX6 iATU is used for address translation between the AXI bus
> address space and PCI address space.  This is used for type0 and type1
> config cycles but is not necessary for outbound io/mem regions.
> 
> This patch removes the calls that inappropriately re-configures the ATU
> viewport for outbound memory and IO after config cycles and removes them
> altogether as they are not necessary.
> 
> This resolves issues with PCI devices behind switches and has been tested
> with a Gige device behind a PLX PEX860x switch.  More testing is needed
> for other configurations.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

This probably needs further fixes to the DT on exynos and omap. And it also 
needs testing on those platforms as this was developed on freescale mx6.

Best regards,
Marek Vasut
