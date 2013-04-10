From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 10 Apr 2013 14:48:17 -0500
Subject: [PATCH 1/5] gpio/omap: free irq domain in probe() failure paths
In-Reply-To: <CACRpkdbGw8_eL2KbXU2FxSrDof=O_5tA+siZDLvTqERqa650wA@mail.gmail.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-2-git-send-email-jon-hunter@ti.com>
 <CACRpkdbGw8_eL2KbXU2FxSrDof=O_5tA+siZDLvTqERqa650wA@mail.gmail.com>
Message-ID: <5165C201.8010500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/10/2013 02:33 PM, Linus Walleij wrote:
> On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> 
>> Currently the IRQ domain is not freed once allocated, in the case where
>> omap_gpio_probe() fails. Therefore, ensure we free the domain if the
>> probe does fail. Furthermore, the local variable "ret" is not needed
>> and so remove this.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Hm Kevin is still listed as maintainer on this driver but on a mail
> address that bounces, can you send a patch replacing him in MAINTAINERS
> with yourself if you're willing to pick it up?
> 
> Anyway, patch applied.

Thanks. There is a patch to fix this queued for v3.10 [1].

Cheers
Jon

[1]
http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/MAINTAINERS?h=for-next&id=c69d72aec52eb5234f433259ac5dcc3b68f1480d
