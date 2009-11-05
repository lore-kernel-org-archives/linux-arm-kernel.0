From: daniel@caiaq.de (Daniel Mack)
Date: Thu,  5 Nov 2009 18:13:33 +0100
Subject: Patches for mxcmmc.c
Message-ID: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are three update patches for the mxc mmc driver to bring it closer
to a working SDIO implementation.

(There is one more pending which modifies the way the buffers' busy
 flags are interpreted, but we're not yet sure whether this one does
 the right thing, so I'm not yet posting it now.)

I'm not sure whether the problems we're having here are due to the
fact that DMA does not yet work on MX3. Hence, I would appreciate if
anyone with access to an MX2 board could try these patches and see
if the hardware can talk to SDIO connected peripherals (preferably
a Libertas Wifi solution, but trying anything else might also give
a hint).

Thanks,
Daniel

[PATCH 1/3] ARM: MXC: mxcmmc: misc cleanups
[PATCH 2/3] ARM: MXC: mxcmmc: Fix max_seg_size assignment
[PATCH 3/3] ARM: MXC: mxcmmc: Teach the driver SDIO operations
