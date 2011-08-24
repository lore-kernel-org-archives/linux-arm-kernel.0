From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 24 Aug 2011 19:12:10 +0900
Subject: [PATCH 2/3] mach-ux500: initialize l2x0 at arch_init time
In-Reply-To: <4E54CAE8.1060702@ti.com>
References: <1314177826-19151-1-git-send-email-linus.walleij@stericsson.com>
	<4E54CAE8.1060702@ti.com>
Message-ID: <CAH9JG2W+KkTZJ67eDqju3jQfc8OZhf0gBzKvhSodpOQS=-q2kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 6:56 PM, Santosh <santosh.shilimkar@ti.com> wrote:
> On Wednesday 24 August 2011 02:53 PM, Linus Walleij wrote:
>>
>> From: Linus Walleij<linus.walleij@linaro.org>
>>
>> mach-imx initialize their l2x0 cach at arch_init time, so
>> why shouldn't we.
>>
> More and more you delay L2 cache enable in boot-process,
> your boot-up time is going to shoot-up.
>
> Have you thought about it. Cache's should be enabled as
> early as possible.

Right, after change from early_init to arch_init. it takes more time.

Before:
...
[    0.046683] L310 cache controller enabled
[    0.046697] l2x0: 16 ways, CACHE_ID 0x4100c4c5, AUX_CTRL
0x7e470001, Cache size: 1048576 B
[    0.096785] CPU1: Booted secondary processor
[    0.096812] CPU1: Unknown IPI message 0x1
[    0.116577] Brought up 2 CPUs
[    0.116591] SMP: Total of 2 processors activated (3181.77 BogoMIPS).
...
[    1.602813] Freeing init memory: 124K

After:
[    0.116616] SMP: Total of 2 processors activated (3181.77 BogoMIPS).
[    0.128712] print_constraints: dummy:
...
[    0.135811] L310 cache controller enabled
[    0.135825] l2x0: 16 ways, CACHE_ID 0x4100c4c5, AUX_CTRL
0x7e470001, Cache size: 1048576 B
...
[    1.688122] Freeing init memory: 124K

Thank you,
Kyungmin Park
