From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 21 Oct 2010 18:55:14 +0200
Subject: [PATCH 00/25] ASoC: Overhaul Samsung drivers
In-Reply-To: <1287473432-19408-1-git-send-email-jassi.brar@samsung.com>
References: <1287473432-19408-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <4CC07072.90100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 19-10-10 09:30, Jassi Brar schreef:
> I forgot to CC you on the patches.
>
> --------
>
> Hi,
>
> Here come patches overhauling the Samsung ASoC support.
>
> The AC97, PCM, SPDIF and ASoC-DMA related code has merely undergone
> cosmetic changes - symbol, device & driver renaming and file moving.
>
> A new I2S controller driver has been added to manage Samsung SoCs since
> S3C64XX. Older driver has been changed only as is necessary.
> Regarding I2S, I have left the s3c24xx series untouched because the
> controllers are too different to run by a common driver. S3C2412's I2S
> does have some similarities, but not important enough to warrant impact
> on new driver design.
> The new I2S driver has been designed around the notion of features/quirks.
> The newer SoCs have revised version of I2S_0(usually) than previous ones.
> So, I2S block is 'specified' in the platform code and the driver works on
> that configuration.
> For now, Secondary I2S DAI works only with System-DMAC. I2S-Internal DMA
> and SRAM will be enabled later.
>
> Testing:-
>   Simple testing of 5.1 channel and hardware mixing seems to work (though
> there seems to be some issue with symmetric_rates in soc-core.c which
> would be tried to fix later as saperate issue).
>  I would appreciate any test-results for GONI and SMARTQ.
>
> I suggest the patches 13,14,16 & 17 go via Kgene's Tree, and the rest via ASoC
> tree due to tight dependencies.
>
> 1). ASoC: WM8580: Remove useless assignment
> 2). ASoC: Samsung: Remove redundant AQUILA driver
> 3). ASoC: Samsung: Rename DMA device
> 4). ARM: Samsung: Define common audio-dma device
> 5). ASoC: Samsung: Rename ASoC DMA driver
> 6). ASoC: Samsung: Rename AC97 platform device
> 7). ASoC: Samsung: Rename AC97 driver
> 8). ASoC: Samsung: Rename PCM driver
> 9). ASoC: Samsung: Generalize DMA driver namespace
> 10). ASoC: Samsung: Rename s3c64xx I2S device
> 11). ASoC: Samsung: Add common I2S driver
> 12). ARM: S3C64XX: I2S: Upgrade platform device
> 13). ARM: S5P6440: I2S: Upgrade platform device
> 14). ARM: S5P6442: I2S: Upgrade platform device
> 15). ARM: S5PC100: I2S: Upgrade platform device
> 16). ARM: S5PV210: I2S: Upgrade platform device
> 17). ARM: S5PV310: Add audio platform devices
> 18). ASoC: SMARTQ: Move to use new I2S driver
> 19). ASoC: GONI: Move to use new I2S driver
> 20). ASoC: SMDK64XX: Move to use new I2S driver
> 21). ASoC: S3C64XX: Remove obsoleted I2S drivers
> 22). ASoC: SMDK64XX: Rename for other platforms
> 23). ASoC: SMDK_WM8580: Enable for SMDKC100
> 24). ASoC: Samsung: Generalize Kconfig symbols
> 25). ASoC: Samsung: Rename from s3c24xx to samsung

These don't seem to apply on Linus' latest release
(f6f94e2ab1b33f0082ac22d71f66385a60d8157f)?

Also, do you have a git tree I can pull to test these?

-- 
Maurus Cuelenaere
