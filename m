From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 13 Sep 2012 08:47:06 +0200
Subject: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <505107DF.5020105@gmail.com>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
 <5050CE33.9060909@ti.com> <5050E965.5080405@linutronix.de>
 <505107DF.5020105@gmail.com>
Message-ID: <5051816A.3050705@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 12:08 AM, Rob Herring wrote:
>> Geert is right here. If it is a physical address, it should be
>> phys_addr_t.
>
> While generally true, for the DT specific code I think it should be a
> fixed u64. The size of the address is defined by the FDT, not the
> kernel. It is very likely we could have a FDT that specifies addresses
> in 64-bit values, but then we boot a kernel is compiled for !LPAE.
> phys_addr_t is currently sized based on LPAE setting.

If your kernel is 32bit without PAE and your DTB address is >32ibt than
you can't handle it. If you don't notice this in your dt code than you
remap the wrong memory ioremap().

>
> Rob
>

Sebastian
