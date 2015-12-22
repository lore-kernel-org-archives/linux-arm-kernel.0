From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 22 Dec 2015 08:19:25 +0100
Subject: [arm:for-next 20/25] /tmp/ccMMP9pi.s:67: Error: selected
 processor does not support ARM mode `isb'
In-Reply-To: <201512221324.RTacS2Z7%fengguang.wu@intel.com>
References: <201512221324.RTacS2Z7%fengguang.wu@intel.com>
Message-ID: <CAKv+Gu98U0z_8FiyqgsdZkxc5P+jzNE1vj4BRSBsn7+7_8X2wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2015 at 06:08, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
> head:   952b96ba23e34ebe3ebef561336986005f3d8425
> commit: 9afc4686531bf701670f329217b8b044ccd95297 [20/25] ARM: 8452/2: PJ4: make coprocessor access sequences buildable in Thumb2 mode
> config: arm-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 9afc4686531bf701670f329217b8b044ccd95297
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>    /tmp/ccMMP9pi.s: Assembler messages:
>>> /tmp/ccMMP9pi.s:67: Error: selected processor does not support ARM mode `isb'
>

Sigh. Apologies for this.

I updated the patch to only use the 'isb' if CONFIG_THUMB2_KERNEL is defined.
