From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 4 Oct 2017 10:36:57 +0200
Subject: regression introduced by commit 70d435ba1cd6 ("ASoC: imx-pcm-dma:
 simplify pcm_config")
Message-ID: <20171004103657.1c6a433d@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the commit 70d435ba1cd6 ("ASoC: imx-pcm-dma: simplify pcm_config")
introduced a regression on the Ka-Ro TX series modules (and possibly
other hardware as well).

The problem is, that this commit restricts the supported sound formats
to S24_LE only rather than S16_LE, S24_LE, S20_3LE without the
patch. Therefore aplay fails with the following error messages, when
trying to play a sound file with S16_LE format:
|ALSA lib alsa-lib-1.1.2/src/pcm/pcm_params.c:2162:(snd1_pcm_hw_refine_slave) Slave PCM not usable
|aplay: set_params:1204: Broken configuration for this PCM: no configurations available

This is with the simple-sound-card driver as well as the imx-sgtl5000
driver.

Can someone tell me on what hardware and with what software has this
patch been tested?


Lothar Wa?mann
