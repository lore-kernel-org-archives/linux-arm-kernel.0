From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 29 Sep 2010 23:52:50 +0200
Subject: [PATCH] amba-pl011: add missing ST specific registers
In-Reply-To: <20100929145932.GG30987@game.jcrosoft.org>
References: <1285764689-4772-1-git-send-email-linus.walleij@stericsson.com>
	<20100929145932.GG30987@game.jcrosoft.org>
Message-ID: <AANLkTik4nUG+6Mjaf+7fQ5CwdYNv9nSDmzkeyirhA3Kt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/29 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> On 14:51 Wed 29 Sep ? ? , Linus Walleij wrote:
>> From: Jonas Aaberg <jonas.aberg@stericsson.com>
>>
>> The ST Micro derivates have several extra interesting registers
>> that we may soon use for something interesting so may just as
>> well define them in the header.
>>
>> Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>> ---
>> ?include/linux/amba/serial.h | ? 11 +++++++++++
>> ?1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
>> index e1b634b..6021588 100644
>> --- a/include/linux/amba/serial.h
>> +++ b/include/linux/amba/serial.h
>> @@ -32,7 +32,9 @@
>> ?#define UART01x_RSR ? ? ? ? ?0x04 ? ?/* Receive status register (Read). */
>> ?#define UART01x_ECR ? ? ? ? ?0x04 ? ?/* Error clear register (Write). */
>> ?#define UART010_LCRH ? ? ? ? 0x08 ? ?/* Line control register, high byte. */
>> +#define ST_UART011_DMAWM ? ? 0x08 ? ?/* DMA watermark configure register. */
> this
>> ?#define UART010_LCRM ? ? ? ? 0x0C ? ?/* Line control register, middle byte. */
>> +#define ST_UART011_TIMEOUT ? 0x0C ? ?/* Timeout period register. */
> abd this are overwritng the default register how do plan to handle it?

No it really isn't. (Unless I misunderstand what you're saying here.)

The other register is for the PL010 serial/amba-pl010.c and this patch adds
registers used in our PL011 derivate in serial/amba-pl011.c, it is a habit
of our hardware engineers to recycle register allocations from PL010
for the new PL011 derivate.

Even if they did overlap (as is the case in some other PrimeCell drivers)
we usually handle this by runtime-switches per PrimeCell ID-based
vendor data so there is a clear design pattern for how to handle that.

> btw you have whitespace in patch

Where? I can only see tabs.. I even downloaded the patch off the list
and ran it through checkpatch in the fears there was. We usually adjust
our whitespace to be the same as the file we're changing but in this case
even checkpatch is happy.

Yours
Linus Walleij
