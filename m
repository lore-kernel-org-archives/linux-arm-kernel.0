From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Nov 2013 10:34:43 +0000
Subject: [PATCH] spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()
In-Reply-To: <CAPgLHd_-cpipSk5+SVPwZ0_Jzx2P5tJVFaj8Rxkbb_+yFVqvEg@mail.gmail.com>
References: <CAPgLHd_-cpipSk5+SVPwZ0_Jzx2P5tJVFaj8Rxkbb_+yFVqvEg@mail.gmail.com>
Message-ID: <20131115103443.GC26614@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 03:54:16PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will
> leak a reference to master. Fix by removing the unnecessary
> spi_master_get() call.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131115/1b398e42/attachment-0001.sig>
