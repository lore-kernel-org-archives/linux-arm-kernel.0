From: pmeerw@pmeerw.net (Peter Meerwald-Stadler)
Date: Mon, 4 Jul 2016 21:00:11 +0200 (CEST)
Subject: atmel_ssc_dai.c, use of dai->id
Message-ID: <alpine.DEB.2.02.1607041956420.11824@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am trying to use SSC1 (not SSC0 which might work) on a SAMA5D4-Xplained 
board (4.1 kernel, but close to mainline)

c706f2e5 ASoC: atmel_ssc_dai: distinguish the different SSC
fixes an issue with cpu_dai id being always 0, while the ssc id should 
have been used (or the platform_device id)

I think there is a remaining issue with DMA parameters in 
atmel_ssc_startup():

line 324:
dma_params = &ssc_dma_params[dai->id][dir];

I think it should be 
dma_params = &ssc_dma_params[pdev->id][dir];

I am new to this platform, please comment
I can submit a formal patch later-on of course

thanks, regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
