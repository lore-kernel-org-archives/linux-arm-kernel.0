From: yuanzhichang@hisilicon.com (zhichang.yuan)
Date: Wed, 14 Sep 2016 19:48:49 +0800
Subject: [PATCH V2 3/4] ARM64 LPC: support serial based on low-pin-count
In-Reply-To: <2531252.L41vzyMSKX@wuerfel>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <5345060.9D0B4ujt5e@wuerfel> <57D1349D.8070905@gmail.com>
 <2531252.L41vzyMSKX@wuerfel>
Message-ID: <57D93921.50303@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/9/8 17:58, Arnd Bergmann wrote:
> On Thursday, September 8, 2016 5:51:25 PM CEST zhichang wrote:
>> On 2016?09?07? 22:50, Arnd Bergmann wrote:
>>> On Wednesday, September 7, 2016 9:33:52 PM CEST Zhichang Yuan wrote:
>>>> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
>>>>
>>>> On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
>>>> controlled through the LPC I/O cycles. This patch drives the UART port with
>>>> the specific serial in/out function pair based on the indirect-IO mechanism
>>>> introduced by Hip06 LPC driver.
>>>>
>>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>>
>>> Any reason this cannot just use the regular drivers/tty/serial/8250/8250_of.c
>>> driver?
>> I think two reasons for that:
>> 1. 8250_of.c is only for devicetree, but we need to support ACPI device too;
> 
> ACPI has its own way of describing serial ports, use that instead.
Could you give me some info about ACPI serial ports?
I found there is _CRS specific for serial, but it seems no serial driver use that.

Thanks!
Zhichang

> 
>> 2. It seems UPIO_PORT is not supported there.
> 
> Should be easy enough to add.
> 
> 	Arnd
> 
> .
> 
