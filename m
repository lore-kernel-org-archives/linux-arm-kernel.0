From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 12 Sep 2012 21:58:29 +0200
Subject: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <5050CE33.9060909@ti.com>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
 <5050CE33.9060909@ti.com>
Message-ID: <5050E965.5080405@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 08:02 PM, Cyril Chemparathy wrote:
>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>> unsigned long end)
>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>
>> Why not phys_addr_t?
>>
>
> The rest of the memory specific bits of the device-tree code use u64 for
> addresses, and I kept it the same for consistency.

Geert is right here. If it is a physical address, it should be
phys_addr_t.

Sebastian
