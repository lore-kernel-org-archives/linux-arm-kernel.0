From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 20 Jun 2015 16:32:16 -0400
Subject: [PATCH v7 00/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <20150619142444.GA15234@gondor.apana.org.au>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150619142444.GA15234@gondor.apana.org.au>
Message-ID: <CAP=VYLqQynCNRTpm4JnOxeO6DH_739fO2QNcDMxaXqCKCHiTtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 10:24 AM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Thu, Jun 18, 2015 at 03:46:16PM +0200, Boris Brezillon wrote:
>> Hello,
>>
>> This patch series adds a new driver supporting Marvell's CESA IP.
>> This driver addresses some limitations of the existing one.
>> >From a performance and CPU load point of view the most important
>> limitation in the existing driver is the lack of DMA support, thus
>> preventing us from chaining crypto operations.
>
> All applied to cryptodev.  Thanks a lot!

It seems this breaks linux-next allmodconfig on i386:

http://kisskb.ellerman.id.au/kisskb/buildresult/12445342/

ERROR: "phys_to_dma" [drivers/crypto/marvell/marvell-cesa.ko] undefined!
make[2]: *** [__modpost] Error 1

Paul.
--
