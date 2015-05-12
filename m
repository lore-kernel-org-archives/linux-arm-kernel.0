From: daniels@collabora.com (Daniel Stone)
Date: Tue, 12 May 2015 07:33:04 +0100
Subject: "drm: Add reference counting to blob properties" breaks Tegra124
 Jetson TK1 in linux-next
In-Reply-To: <55517AE5.30700@nvidia.com>
References: <55517AE5.30700@nvidia.com>
Message-ID: <5DC9157B-3CE7-4794-B77A-865C609DFB05@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> On 12 May 2015, at 5:00 am, Paul Walmsley <pwalmsley@nvidia.com> wrote:
> 
> Hi folks
> 
> Tegra124 Jetson TK1 hangs during boot in next-20150508 and beyond:
> 
> http://nvt.pwsan.com/experimental/linux-next/testlogs/test_next-20150508/20150508101018/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt 
> http://nvt.pwsan.com/experimental/linux-next/testlogs/test_next-20150511/20150511004533/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt 

Weirdly enough, it seems to work in kernelci:
http://kernelci.org/boot/tegra124-jetson-tk1_rootfs:nfs/job/next/kernel/next-20150511/defconfig/tegra_defconfig/lab/lab-khilman/?_id=5550ef6259b5147b64e060b4

Though maybe it's just good fortune that Kevin doesn't have a display plugged into his TK1.

> Reverting commit 672cb1d6aec7da2799afd1b529d5136d84ed2561 ("drm: Add reference counting to blob properties") gets it booting again:
> 
> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150511204703_3838232431c2636ff539f2354c630c0ca3d4b7ad/20150511204703/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt
> 
> I'm not a DRM expert but maybe one of you knows what's going on here?

Thanks for the catch. I have a Nyan-Big Chromebook here, so will try to work it out locally and let you know.

Sorry for the inconvenience!

Cheers,
Daniel
