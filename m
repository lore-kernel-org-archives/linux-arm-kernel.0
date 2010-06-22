From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 22 Jun 2010 17:34:07 +0800
Subject: [PATCH 05/25] pxa3xx_nand: rework irq logic
In-Reply-To: <AANLkTikTzNY2hI0JDTOOZpGeOPc_MU79jVJ_1L9XxA_e@mail.gmail.com>
References: <AANLkTimvhEWIDupsj3Ty8vB9ualwU9RsaIxa0CDgWgYQ@mail.gmail.com>
	<AANLkTikTzNY2hI0JDTOOZpGeOPc_MU79jVJ_1L9XxA_e@mail.gmail.com>
Message-ID: <AANLkTikmuCHqJQY2g8G3FsrufO5dKGt9WNZFnmvoSGl2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 2:50 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 1:34 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From 18d589a078871a09dec0862241fedd2d1d07be85 Mon Sep 17 00:00:00 2001
>> From: Lei Wen <leiwen@marvell.com>
>> Date: Mon, 31 May 2010 14:05:46 +0800
>> Subject: [PATCH 05/25] pxa3xx_nand: rework irq logic
>>
>> Enable all irq when we start the nand controller, and
>> put all the transaction logic in the pxa3xx_nand_irq.
>>
>
> Didn't look into the change too much, but the idea sounds to me like
> chaining all the logic with different IRQ events, which was my original
> reason of having different states. And considering the page read/write
> is actually to an internal SRAM within the controller, I guess it's quick
> enough. (though I'd suggest to do some experiments of time profiling
> to see if it's going to increase the interrupt latency)
>
>> By doing this way, we could dramatically increase the
>> performance by avoid unnecessary delay.
>>
>
> The removal of __read_id() doesn't look to be part of this patch, no?
>
For write_cmd function has been discard and __read_id function would
not be used, if
continue to keep the __read_id() definition would lead to make failure...

Best regards,
Lei
