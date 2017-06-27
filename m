From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Jun 2017 14:09:33 +0800
Subject: [PATCH v13 08/14] ASoC: sun4i-codec: Add FM Left, FM Right, FM
 Playback Switch.
In-Reply-To: <20170624062419.23778-9-dannym@scratchpost.org>
Message-ID: <201706271441.UxZIRl0Q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Danny,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on next-20170626]
[cannot apply to v4.12-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Danny-Milosavljevic/ASoC-sun4i-codec-Add-MIC2-Pre-Amplifier-Mic2/20170626-090107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

Note: the linux-review/Danny-Milosavljevic/ASoC-sun4i-codec-Add-MIC2-Pre-Amplifier-Mic2/20170626-090107 HEAD 44ff3730ffe45aa10f8cfeaf31443f0b7a78227f builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   In file included from sound/soc/sunxi/sun4i-codec.c:39:0:
>> sound/soc/sunxi/sun4i-codec.c:706:4: error: 'SUN4I_CODEC_DAC_ACTL_LFMS' undeclared here (not in a function)
       SUN4I_CODEC_DAC_ACTL_LFMS,
       ^
   include/sound/soc.h:36:39: note: in definition of macro 'SOC_DOUBLE_VALUE'
     {.reg = xreg, .rreg = xreg, .shift = shift_left, \
                                          ^~~~~~~~~~
>> sound/soc/sunxi/sun4i-codec.c:705:2: note: in expansion of macro 'SOC_DAPM_DOUBLE'
     SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
     ^~~~~~~~~~~~~~~
>> sound/soc/sunxi/sun4i-codec.c:707:4: error: 'SUN4I_CODEC_DAC_ACTL_RFMS' undeclared here (not in a function)
       SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
       ^
   include/sound/soc.h:37:12: note: in definition of macro 'SOC_DOUBLE_VALUE'
     .rshift = shift_right, .max = xmax, .platform_max = xmax, \
               ^~~~~~~~~~~
>> sound/soc/sunxi/sun4i-codec.c:705:2: note: in expansion of macro 'SOC_DAPM_DOUBLE'
     SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
     ^~~~~~~~~~~~~~~

vim +/SUN4I_CODEC_DAC_ACTL_LFMS +706 sound/soc/sunxi/sun4i-codec.c

   699		SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
   700				SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
   701				SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
   702		SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
   703				SUN4I_CODEC_DAC_ACTL,
   704				SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
 > 705		SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
 > 706				SUN4I_CODEC_DAC_ACTL_LFMS,
 > 707				SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
   708		SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
   709				SUN4I_CODEC_DAC_ACTL_MIC1LS,
   710				SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44869 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170627/2387d205/attachment-0001.gz>
