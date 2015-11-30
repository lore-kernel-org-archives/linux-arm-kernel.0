From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 Dec 2015 00:21:38 +0800
Subject: [PATCH] ASoC: sun4i: Implement MIC1 capture
In-Reply-To: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201512010037.EApupzFS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[auto build test WARNING on: v4.4-rc3]
[cannot apply to: asoc/for-next next-20151127]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/ASoC-sun4i-Implement-MIC1-capture/20151130-234314
config: i386-randconfig-i0-201548 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   sound/soc/sunxi/sun4i-codec.c: In function 'sun4i_codec_hw_params_capture':
>> sound/soc/sunxi/sun4i-codec.c:361:6: warning: unused variable 'val' [-Wunused-variable]
     u32 val;
         ^

vim +/val +361 sound/soc/sunxi/sun4i-codec.c

45fb6b6f Emilio L?pez  2015-09-12  345  	case 11025:
45fb6b6f Emilio L?pez  2015-09-12  346  		return 4;
45fb6b6f Emilio L?pez  2015-09-12  347  
45fb6b6f Emilio L?pez  2015-09-12  348  	case 8000:
45fb6b6f Emilio L?pez  2015-09-12  349  	case 7350:
45fb6b6f Emilio L?pez  2015-09-12  350  		return 5;
45fb6b6f Emilio L?pez  2015-09-12  351  
45fb6b6f Emilio L?pez  2015-09-12  352  	default:
45fb6b6f Emilio L?pez  2015-09-12  353  		return -EINVAL;
45fb6b6f Emilio L?pez  2015-09-12  354  	}
45fb6b6f Emilio L?pez  2015-09-12  355  }
45fb6b6f Emilio L?pez  2015-09-12  356  
e6fdf863 Maxime Ripard 2015-11-30  357  static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
45fb6b6f Emilio L?pez  2015-09-12  358  					 struct snd_pcm_hw_params *params,
e6fdf863 Maxime Ripard 2015-11-30  359  					 unsigned int hwrate)
45fb6b6f Emilio L?pez  2015-09-12  360  {
45fb6b6f Emilio L?pez  2015-09-12 @361  	u32 val;
45fb6b6f Emilio L?pez  2015-09-12  362  
e6fdf863 Maxime Ripard 2015-11-30  363  	/* Set ADC sample rate */
e6fdf863 Maxime Ripard 2015-11-30  364  	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
e6fdf863 Maxime Ripard 2015-11-30  365  			   7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
e6fdf863 Maxime Ripard 2015-11-30  366  			   hwrate << SUN4I_CODEC_ADC_FIFOC_ADC_FS);
45fb6b6f Emilio L?pez  2015-09-12  367  
e6fdf863 Maxime Ripard 2015-11-30  368  	/* Set the number of channels we want to use */
e6fdf863 Maxime Ripard 2015-11-30  369  	if (params_channels(params) == 1)

:::::: The code at line 361 was first introduced by commit
:::::: 45fb6b6f2aa3f6b22b81078db0dba4b26c9d0bdb ASoC: sunxi: add support for the on-chip codec on early Allwinner SoCs

:::::: TO: Emilio L?pez <emilio@elopez.com.ar>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24519 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/5a68c78e/attachment-0001.obj>
