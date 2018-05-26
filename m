From: broonie@kernel.org (Mark Brown)
Date: Sat, 26 May 2018 11:36:29 +0100
Subject: Boot failures in -next on Jetson TK1
Message-ID: <20180526103629.GB1564@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently -next is failing to boot on Jetson TK1.  The problem looks to
be the Nouveau driver, during initialization it reports an address
decode error then starts printing error messages saying "nouveau
57000000.gpu: fifo: SCHED_ERROR 20 []" over and over again.

I've pasted the start of the errors below, you can see a full log and
more details at:

   https://kernelci.org/boot/id/5b0882a259b514339779a881/

The warnings about Spectre are a separate issue and don't seem to affect
the boot.

[ 15.194484] nouveau 57000000.gpu: NVIDIA GK20A (0ea000a1)
[   15.200109] udevd[109]: could not rename interface '3' from 'eth0' to 'enp1s0': Device or resource busy
[   15.206399] nouveau 57000000.gpu: imem: using IOMMU
[   15.315122] CPU2: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[   15.320021] nouveau 57000000.gpu: Direct firmware load for nvidia/gk20a/fecs_inst.bin failed with error -2
[   15.384841] nouveau 57000000.gpu: Direct firmware load for nouveau/nvea_fuc409c failed with error -2
[   15.393972] nouveau 57000000.gpu: Direct firmware load for nouveau/fuc409c failed with error -2
[   15.402679] nouveau 57000000.gpu: gr: failed to load fuc409c
[   15.409434] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[   15.419398] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[   15.482568] tegra-mc 70019000.memory-controller: gpusrd: read @0x00041200: EMEM address decode error (EMEM decode error)
[   15.491232] [TTM] Zone  kernel: Available graphics memory: 375202 kiB
[   15.502768] [TTM] Zone highmem: Available graphics memory: 1030050 kiB
[   15.509290] [TTM] Initializing pool allocator
[   15.513658] nouveau 57000000.gpu: DRM: VRAM: 0 MiB
[   15.518451] nouveau 57000000.gpu: DRM: GART: 1048576 MiB
[   15.526546] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[   15.527290] tegra-mc 70019000.memory-controller: gpusrd: read @0x00072000: EMEM address decode error (EMEM decode error)
[   15.537050] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[   15.546928] nouveau 57000000.gpu: fifo: SCHED_ERROR 20 []
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180526/689741b6/attachment.sig>
