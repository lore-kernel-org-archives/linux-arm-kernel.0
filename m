From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 02 Aug 2014 18:46:00 +0200
Subject: [PATCH v3 1/6] clk: add pxa clocks infrastructure
In-Reply-To: <CAN1soZyST84DNvK=zyj6EhOt0fswZ4SvOmMnWiCZsYmapxkhOg@mail.gmail.com>
 (Haojian Zhuang's message of "Sat, 2 Aug 2014 20:00:43 +0800")
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <1406753464-15000-2-git-send-email-robert.jarzmik@free.fr>
 <CAN1soZyST84DNvK=zyj6EhOt0fswZ4SvOmMnWiCZsYmapxkhOg@mail.gmail.com>
Message-ID: <87tx5usuuv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> On Thu, Jul 31, 2014 at 4:50 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> +void __init clkdev_pxa_register(int ckid, const char *con_id,
>> +                               const char *dev_id, struct clk *clk)
>> +{
>> +       if (!IS_ERR(clk) && (ckid != CLK_NONE))
>
> Will you specify CLK_NONE in clock driver?
I haven't found a use yet (ie. pxa27x has no use for it, while for pxa3xx and
pxa25x I don't know yet).
I had put that here for a "CKEN" type clock which would be declared, but hidden
from device-tree. That's the meaning of "CLK_NONE", hidden from DT.

I can remove it if you think that there is no pxaXXX which needs this functionality.

> It seems that CLK_NONE isn't used in pxa27x clock driver. And pxa_clocks[0] is
> not used. Is it redundant?
Yes it is. pxa_clocks[0] is never filled by any clock.

Cheers.

--
Robert
