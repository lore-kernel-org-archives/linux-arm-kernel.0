From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 22 Nov 2018 23:20:04 +0100
Subject: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
In-Reply-To: <20181122212905.GA13187@zn.tnic>
References: <20181102153406.1528053-1-arnd@arndb.de>
 <13542843.KjxkD9786N@anarsoul-thinkpad>
 <CAK8P3a3A-mq2HLZjp7-5miL2Pk71=FqP5QKUxxda_y5ywCa7TA@mail.gmail.com>
 <CA+E=qVfnkH-e6hoHA1eZ7rCJvJH02zgBSF=y30R6AEGwLpssXA@mail.gmail.com>
 <20181122212905.GA13187@zn.tnic>
Message-ID: <s5h5zwoah63.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2018 22:29:05 +0100,
Borislav Petkov wrote:
> 
> On Fri, Nov 02, 2018 at 03:06:59PM -0700, Vasily Khoruzhick wrote:
> > On Fri, Nov 2, 2018 at 3:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On 11/2/18, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > > > On Friday, November 2, 2018 8:33:40 AM PDT Arnd Bergmann wrote:
> > > >> The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
> > > >> symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
> > > >> SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
> > > >> into link errors for some configurations:
> > > >>
> > > >> sound/soc/sunxi/sun50i-codec-analog.o: In function
> > > >> `sun50i_codec_analog_probe': sun50i-codec-analog.c:(.text+0x62):
> > > >> undefined
> > > >> reference to `sun8i_adda_pr_regmap_init'
> > > >>
> > > >> The new name appears to be more sensible, and as the symbol is hidden,
> > > >> there are no downsides in the rename, so use that consistently now.
> > > >
> > > > Maxime asked it to be SND_SUN8I_ADDA_PR_REGMAP, and also it would be easier
> > > > to
> > > > fix it my renaming last remaining SND_SUNXI_ADDA_PR_REGMAP to
> > > > SND_SUN8I_ADDA_PR_REGMAP.
> > >
> > > Sure, I don't care either way. Please send a patch to do that then.
> > 
> > Will do tonight.
> 
> Is that patch coming up or on its way somewhere?
> 
> I still hit randconfig build failures:
> 
> ERROR: "sun8i_adda_pr_regmap_init" [sound/soc/sunxi/sun50i-codec-analog.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

It's been in Mark's asoc tree.

Mark, could you send a pull request?  It might be too late for rc4,
but sooner, better.


thanks,

Takashi
