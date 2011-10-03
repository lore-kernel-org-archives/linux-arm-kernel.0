From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 13:50:08 +0200
Subject: [alsa-devel] [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
In-Reply-To: <004e01cc8198$848347f0$8d89d7d0$@com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<3289863.m6ULFZUV3p@wuerfel> <004e01cc8198$848347f0$8d89d7d0$@com>
Message-ID: <1869072.QQLATNzYYx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 15:48:54 Sangbeom Kim wrote:
> On Mon, Oct 03, 2011 at 6:15:03AM , Arnd Bergmann wrote:
> > It's a bug that I only observed on exynos4, and it could be that
> > this patch didn't actually solve it in the end. I'll drop it for
> > now and do a better report when the problem comes back.
> 
> Could you please explain problem which observed on exynos4?
> If possible, I want to check it too.

Sorry, I can't reproduce it any more. It could have been something
unrelated like a Kconfig or toolchain problem that got fixed in
the meantime. I really should have dropped that one hunk from
the patch. The other problem in this patch is still there, with
CONFIG_SND_SOC_SMDK_WM8994_PCM=y and CONFIG_MFD_WM8994=n:

sound/built-in.o: In function `wm8994_resume':
last.c:(.text+0x1f600): undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_read':
last.c:(.text+0x20160): undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_codec_probe':
last.c:(.text+0x2029c): undefined reference to `wm8994_reg_read'
last.c:(.text+0x20480): undefined reference to `wm8994_reg_read'
last.c:(.text+0x204b4): undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_write':
last.c:(.text+0x20e68): undefined reference to `wm8994_reg_write'
last.c:(.text+0x20ea4): undefined reference to `wm8994_reg_write'
sound/built-in.o: In function `wm8958_dsp2_fw':
last.c:(.text+0x2159c): undefined reference to `wm8994_bulk_write'

	Arnd
