From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 29 Jan 2014 19:33:51 +0100
Subject: [RFC PATCH v2 09/14] mtd: nand: add sunxi NFC dt bindings doc
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA6C01D@DBDE04.ent.ti.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-10-git-send-email-b.brezillon.dev@gmail.com>
 <CAL_JsqLVr1gSLArqtfOiHce+u6ZK8FiKMX0o9bvMrMoGGhATvg@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA6C01D@DBDE04.ent.ti.com>
Message-ID: <52E9498F.8090709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/01/2014 19:02, Gupta, Pekon a ?crit :
> Dear Rob, and other DT maintainers,
>
>> From: Rob Herring
> [...]
>>> +- onfi,nand-timing-mode : mandatory if the chip does not support the ONFI
>>> +  standard.
>> Add to generic nand binding.
>>
>>> +- allwinner,rb : shall contain the native Ready/Busy ids.
>>> + or
>>> +- rb-gpios : shall contain the gpios used as R/B pins.
>> Isn't allwinner,rb implied by a lack of rb-gpios property. Or no R/B
>> pin is an option? If so, don't you need some fixed time delay
>> properties like max erase time?
>>
>> rb-gpios could be added to the generic nand binding as well.
>>
> I do think this should go into generic nand binding, as this is controller specific.
> Some controllers have dedicated R/B pin (Ready/Busy) while others may use
> GPIO instead. It's the way a hardware controller is designed.

You meant "You do not think", right ?
If so, I think even if the retrieval and control of the GPIO is done is 
each NAND
controller, we could at least use a common property name for all drivers 
using
a GPIO to detect the R/B state.

> Request you to please consider Ack from MTD Maintainers 'at-least' for
> generic NAND DT bindings. There is already a discussion going in
> a separate thread for which is still not awaiting replies [1].
>
> [1]http://lists.infradead.org/pipermail/linux-mtd/2014-January/051625.html

I missed this thread, but I can definitely use the nand-ecc-strength and
nand-ecc-step-size instead of the one I defined (nand-ecc-level), as long
as there is a proper way to define these informations in the DT.

I'll let DT and MTD maintainers decide ;-).

Best Regards,

Boris
>
> with regards, pekon
