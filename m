From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 20:54:03 +0100
Subject: [PATCH v3] crypto: atmel: fix bogus select
In-Reply-To: <201511190227.fHF3LVfw%fengguang.wu@intel.com>
References: <201511190227.fHF3LVfw%fengguang.wu@intel.com>
Message-ID: <3878434.NqzKGChk39@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 November 2015 02:17:21 kbuild test robot wrote:
> 
> [auto build test WARNING on: cryptodev/master]
> [also build test WARNING on: v4.4-rc1 next-20151118]
> 
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/crypto-atmel-fix-bogus-select/20151118-233706
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> config: tile-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=tile 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/crypto/atmel-aes.c: In function 'atmel_aes_sg_copy':
> >> drivers/crypto/atmel-aes.c:191:11: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>    drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_start':
>    drivers/crypto/atmel-aes.c:447:11: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>    drivers/crypto/atmel-aes.c:448:11: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>    drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_stop':
> >> drivers/crypto/atmel-aes.c:642:5: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'size_t' [-Wformat]
>    drivers/crypto/atmel-aes.c: In function 'atmel_aes_buff_init':
> >> drivers/crypto/atmel-aes.c:669:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' [-Wformat]
>    drivers/crypto/atmel-aes.c:677:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' [-Wformat]
> 
> 

Thanks for the report. I actually submitted a patch for these yesterday, but
I should have realized now that there is a dependency between the two patches,
and the other one needs to be applied first to avoid generating these
warnings in allmodconfig builds for all architectures.

	Arnd
