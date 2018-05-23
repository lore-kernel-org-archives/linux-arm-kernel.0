From: daniel@zonque.org (Daniel Mack)
Date: Wed, 23 May 2018 11:00:31 +0200
Subject: [rjarzmik:test/daniel 23/34] sound/arm/pxa2xx-ac97.c:27:10: fatal
 error: mach/regs-ac97.h: No such file or directory
In-Reply-To: <201805231623.n3Qx9qdU%fengguang.wu@intel.com>
References: <201805231623.n3Qx9qdU%fengguang.wu@intel.com>
Message-ID: <8545409a-475f-1821-fcef-60b2f85101b6@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert,

On Wednesday, May 23, 2018 10:46 AM, kbuild test robot wrote:
> tree:   https://github.com/rjarzmik/linux test/daniel
> head:   f495e2dbc482d8f01a1ee20e86284ee9c0c8fa98
> commit: 4cd654b13b9bcc0f206d414497b798ed42df573a [23/34] HACK: select SND_PXA_SOC_SSP for SND_SIMPLE_CARD

This patch is just a local hack in one of my scratch-pad branches and is 
not meant for upstream inclusion. Could you remove the branch or make 
sure it isn't picked up by test robots?


Thanks,
Daniel


> config: x86_64-randconfig-s3-05231547 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          git checkout 4cd654b13b9bcc0f206d414497b798ed42df573a
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>>> sound/arm/pxa2xx-ac97.c:27:10: fatal error: mach/regs-ac97.h: No such file or directory
>      #include <mach/regs-ac97.h>
>               ^~~~~~~~~~~~~~~~~~
>     compilation terminated.
> --
>>> sound/soc/pxa/pxa2xx-i2s.c:28:10: fatal error: mach/hardware.h: No such file or directory
>      #include <mach/hardware.h>
>               ^~~~~~~~~~~~~~~~~
>     compilation terminated.
> 
> vim +27 sound/arm/pxa2xx-ac97.c
> 
> 2c484df0 Takashi Iwai 2005-06-30  26
> 1f017a99 Eric Miao    2008-11-28 @27  #include <mach/regs-ac97.h>
> a09e64fb Russell King 2008-08-05  28  #include <mach/audio.h>
> 2c484df0 Takashi Iwai 2005-06-30  29
> 
> :::::: The code at line 27 was first introduced by commit
> :::::: 1f017a9964c5b3b9581d3a5732110cb1e0444281 [ARM] pxa: move AC97 register definitions into dedicated regs-ac97.h
> 
> :::::: TO: Eric Miao <eric.miao@marvell.com>
> :::::: CC: Eric Miao <eric.miao@marvell.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
