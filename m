From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed,  9 Mar 2016 00:46:11 +0100
Subject: [PATCH] ARM: pxa: fix the number of DMA requestor lines
Message-ID: <1457480771-24965-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of requestor lines was clamped to 0 for all pxa architectures
in the requestor declaration. Fix this by using the value.

Fixes: 72b195cb7162 ("ARM: pxa: add the number of DMA requestor lines")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/devices.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 913a319c7b00..fffb697bbf0e 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1235,5 +1235,6 @@ static struct platform_device pxa2xx_pxa_dma = {
 void __init pxa2xx_set_dmac_info(int nb_channels, int nb_requestors)
 {
 	pxa_dma_pdata.dma_channels = nb_channels;
+	pxa_dma_pdata.nb_requestors = nb_requestors;
 	pxa_register_device(&pxa2xx_pxa_dma, &pxa_dma_pdata);
 }
-- 
2.1.4
