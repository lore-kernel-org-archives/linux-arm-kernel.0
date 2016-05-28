From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 28 May 2016 18:54:06 +0800
Subject: [rjarzmik:work/ac97 4/7] sound/soc/codecs/.tmp_gl_wm9713.o:undefined
 reference to `compat_release_snd_ac97_codec'
Message-ID: <201605281803.w7MfrmbD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/ac97
head:   3350c2230e9e1331442724f919c86542d9668d4b
commit: 8715b68899fdeea2968c7760843a0f908b4def2c [4/7] ASoC: wm9713: add ac97 new bus support
config: microblaze-allyesconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8715b68899fdeea2968c7760843a0f908b4def2c
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

Note: the rjarzmik/work/ac97 HEAD 3350c2230e9e1331442724f919c86542d9668d4b builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   `.exit.data' referenced in section `.exit.text' of drivers/built-in.o: defined in discarded section `.exit.data' of drivers/built-in.o
   `.exit.data' referenced in section `.exit.text' of drivers/built-in.o: defined in discarded section `.exit.data' of drivers/built-in.o
   sound/built-in.o: In function `wm9713_soc_remove':
>> sound/soc/codecs/.tmp_gl_wm9713.o:(.text+0x921b9c): undefined reference to `compat_release_snd_ac97_codec'
   sound/built-in.o: In function `wm9713_soc_probe':
>> sound/soc/codecs/.tmp_gl_wm9713.o:(.text+0x921c40): undefined reference to `compat_alloc_snd_ac97_codec'
   sound/soc/codecs/.tmp_gl_wm9713.o:(.text+0x921d0c): undefined reference to `compat_release_snd_ac97_codec'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44817 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160528/c9c4fdc0/attachment-0001.obj>
