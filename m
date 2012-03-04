From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 4 Mar 2012 13:47:16 +0200
Subject: [PATCH V2] rpmsg: fix build warning when dma_addr_t is 64-bit
In-Reply-To: <1330530066-17461-1-git-send-email-mark.asselstine@windriver.com>
References: <201202291455.20688.arnd@arndb.de>
 <1330530066-17461-1-git-send-email-mark.asselstine@windriver.com>
Message-ID: <CAK=WgbbjaQm6R3FL-dzpyZtu17Xq28_L6xvOu_tm5PEzm3ESqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 5:41 PM, Mark Asselstine
<mark.asselstine@windriver.com> wrote:
> dev_dbg() in rpmsg_probe() made use of the %x formatting that
> expects an 'unsigned int' which dma_addr_t is not in cases where
> dma_addr_t is 64-bit (CONFIG_ARCH_DMA_ADDR_T_64BIT). Casting to
> a 'unsigned long long' and using %llx will avoid this.
>
> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> CC: Ohad Ben-Cohen <ohad@wizery.com>
> CC: Arnd Bergmann <arnd@arndb.de>

Thanks, Mark !

I'll send this to Arnd later this week together with the other
remoteproc/rpmsg patches.

Ohad.
