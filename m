From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Sep 2016 09:42:25 +0800
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <1474207751-9804-2-git-send-email-ayaka@soulik.info>
Message-ID: <201609190930.MkF7oZVy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.8-rc7 next-20160916]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Randy-Li/ASoC-samsung-make-audio-interface-controller-explicitly/20160918-222618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   sound/built-in.o: In function `s3c_ac97_probe':
>> ac97.c:(.text+0x336f9d): undefined reference to `samsung_asoc_dma_platform_register'
   sound/built-in.o: In function `spdif_probe':
>> spdif.c:(.text+0x3378de): undefined reference to `samsung_asoc_dma_platform_register'
   sound/built-in.o: In function `s3c_pcm_dev_probe':
>> pcm.c:(.text+0x3380e7): undefined reference to `samsung_asoc_dma_platform_register'
   sound/built-in.o: In function `samsung_i2s_probe':
>> i2s.c:(.text+0x338c01): undefined reference to `samsung_asoc_dma_platform_register'
   i2s.c:(.text+0x338ef6): undefined reference to `samsung_asoc_dma_platform_register'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55181 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/580007ea/attachment-0001.obj>
