From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 27 Jun 2016 07:58:43 +0300
Subject: [PATCHv2 06/27] crypto: ahash: increase the maximum allowed
 statesize
In-Reply-To: <20160624103209.GA19607@gondor.apana.org.au>
References: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
 <1466601840-18486-7-git-send-email-t-kristo@ti.com>
 <20160624103209.GA19607@gondor.apana.org.au>
Message-ID: <5770B283.8000902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/06/16 13:32, Herbert Xu wrote:
> On Wed, Jun 22, 2016 at 04:23:39PM +0300, Tero Kristo wrote:
>> The statesize is used to determine the maximum size for saved ahash
>> context. In some cases, this can be much larger than what is currently
>> allocated for it, for example omap-sham driver uses a buffer size of
>> PAGE_SIZE. Increase the statesize to accommodate this.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> Nack.  The exported state is supposed to consist of the actual
> hash state, plus at most one block worth of unhashed data.  It's
> limited so that we can store it on the stack.
>
> So no I'm not taking this patch.
>

Ok, I think I need to allocate the storage space locally then within the 
driver. Would it be ok to call kmalloc / free in the export / import 
implementation of the driver? The size of the unhashed buffer in 
omap-sham is unfortunately rather large.

-Tero
