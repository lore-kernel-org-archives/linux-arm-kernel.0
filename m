From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jun 2017 10:04:33 +0200
Subject: [nomadik:gemini-dir-685-tve200 31/31]
 drivers/gpu//drm/panel/panel-ilitek-ili9322.c:230:16:
 warning: format '%d' expects argument of type 'int', but argument 4 has type
 'size_t {aka long unsigned int}'
In-Reply-To: <201706130958.G1TIEx5u%fengguang.wu@intel.com>
References: <201706130958.G1TIEx5u%fengguang.wu@intel.com>
Message-ID: <CAK8P3a14RUw9Z_PARdE7P_h=Gsc9tC8O67rw2B1oLUude4k13A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 3:48 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-tve200
> head:   454df5dcbcb83585bb77898eea3a0afa6288e441
> commit: 454df5dcbcb83585bb77898eea3a0afa6288e441 [31/31] stab
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 454df5dcbcb83585bb77898eea3a0afa6288e441
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/cdev.h:7:0,
>                     from include/drm/drmP.h:36,
>                     from drivers/gpu//drm/panel/panel-ilitek-ili9322.c:20:
>    drivers/gpu//drm/panel/panel-ilitek-ili9322.c: In function 'ili9322_regmap_spi_read':
>>> drivers/gpu//drm/panel/panel-ilitek-ili9322.c:230:16: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t {aka long unsigned int}' [-Wformat=]
>      dev_info(dev, "READ: %02x reg size = %d, val size = %d\n",
>    227
>    228          /* Set bit 7 to 1 to read */
>    229          memcpy(buf, reg, 1);
>  > 230          dev_info(dev, "READ: %02x reg size = %d, val size = %d\n",
>    231                   buf[0], reg_size, val_size);
>    232          buf[0] |= 0x80;

You want "%zd" instead.

      Arnd
