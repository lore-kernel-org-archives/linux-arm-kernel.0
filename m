From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 11 May 2015 22:00:37 -0600
Subject: "drm: Add reference counting to blob properties" breaks Tegra124
 Jetson TK1 in linux-next
Message-ID: <55517AE5.30700@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks

Tegra124 Jetson TK1 hangs during boot in next-20150508 and beyond:

http://nvt.pwsan.com/experimental/linux-next/testlogs/test_next-20150508/20150508101018/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt 

http://nvt.pwsan.com/experimental/linux-next/testlogs/test_next-20150511/20150511004533/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt 


Reverting commit 672cb1d6aec7da2799afd1b529d5136d84ed2561 ("drm: Add 
reference counting to blob properties") gets it booting again:

http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150511204703_3838232431c2636ff539f2354c630c0ca3d4b7ad/20150511204703/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt

I'm not a DRM expert but maybe one of you knows what's going on here?


- Paul


commit 672cb1d6aec7da2799afd1b529d5136d84ed2561
Author: Daniel Stone <daniels@collabora.com>
Date:   Mon Apr 20 19:22:55 2015 +0100

     drm: Add reference counting to blob properties

     Reference-count drm_property_blob objects, changing the API to
     ref/unref.

     Signed-off-by: Daniel Stone <daniels@collabora.com>
     Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
     Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>


--
nvpublic
