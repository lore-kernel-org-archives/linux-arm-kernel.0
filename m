From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 10 Dec 2012 17:40:57 +1100
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc tree
Message-ID: <20121210174057.9862b43ff7350ba20c048df3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/plat-samsung/include/plat/devs.h between commit a08485d8fdf6
("ASoC: Samsung: Do not register samsung audio dma device as pdev") from
the sound-asoc tree and commit 0a9d5ac307ae ("ARM: EXYNOS: removing
exynos-drm device registration from non-dt platforms") from the arm-soc
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/plat-samsung/include/plat/devs.h
index c45f70c,f53beba..0000000
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@@ -133,8 -132,7 +132,6 @@@ extern struct platform_device exynos4_d
  extern struct platform_device exynos4_device_pcm2;
  extern struct platform_device exynos4_device_spdif;
  
- extern struct platform_device exynos_device_drm;
- 
 -extern struct platform_device samsung_asoc_dma;
  extern struct platform_device samsung_asoc_idma;
  extern struct platform_device samsung_device_keypad;
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121210/46f5b15e/attachment-0001.sig>
