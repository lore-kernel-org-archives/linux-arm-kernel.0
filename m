From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 May 2014 21:10:30 +0200
Subject: [PATCH] ALSA: hda: fix tegra build
In-Reply-To: <s5h61ksjybu.wl%tiwai@suse.de>
References: <4769804.MRZYg8zfIB@wuerfel> <s5h61ksjybu.wl%tiwai@suse.de>
Message-ID: <201405262110.31143.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 May 2014, Takashi Iwai wrote:
> At Mon, 26 May 2014 18:14:21 +0200,
> Arnd Bergmann wrote:
> > 
> > When CONFIG_PM is disabled, the CONFIG_SND_HDA_POWER_SAVE_DEFAULT symbol
> > does not get defined, which causes a build error for the hda-tegra driver:
> > 
> > hda/hda_tegra.c:80:25: error: 'CONFIG_SND_HDA_POWER_SAVE_DEFAULT' undeclared here (not in a function)
> >  static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
> >                          ^
> > /git/arm-soc/sound/pci/hda/hda_tegra.c:235:13: warning: 'hda_tegra_disable_clocks' defined but not used [-Wunused-function]
> >  static void hda_tegra_disable_clocks(struct hda_tegra *data)
> >              ^
> > 
> > This works around the problem by not referencing that macro
> > when CONFIG_PM is disabled. Instead, we assume that it's disabled
> > unconditionally and cannot be enabled at runtime.
> > 
> > Signed-off-by: Dylan Reid <dgreid@chromium.org>
> > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Oh, you cloned me?
> 

Damn, copy-paste error on my side. All three are wrong and should be Cc:,
also my Signed-off-by is missing.

Let me resend.

	Arnd
