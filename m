From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 14:43:43 +0100
Subject: [PATCH] Change the internal SRAM memory type MT_MEMORY_NONCACHED
In-Reply-To: <51B9C6FE.7000302@atmel.com>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
 <1370657863-8725-1-git-send-email-wenyou.yang@atmel.com>
 <51B9C6FE.7000302@atmel.com>
Message-ID: <20130613134342.GE18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 03:19:58PM +0200, Nicolas Ferre wrote:
> On 08/06/2013 04:17, Wenyou Yang :
>> Because MT_DEVICE is not executable in armv7, we change
>> the internal SRAM memory type to MT_MEMORY_NONCACHED.
>> As it seems that caching this internal SRAM memory is not necessary,
>> we chose the this memory type.
>>
>> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> But Russell, can we have your advice on this as you made us re-think  
> about that during previous patch discussion?

I think this is fine - using MT_MEMORY_NONCACHED gets you a memory-like
mapping instead of a strongly ordered or device mapping, but without
caching issues, which is what you want here.
