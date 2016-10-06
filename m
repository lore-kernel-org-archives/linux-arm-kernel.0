From: john.garry@huawei.com (John Garry)
Date: Thu, 6 Oct 2016 14:31:52 +0100
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1475713112.3784.183.camel@kernel.crashing.org>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5140357.dcW9ibtZJ6@wuerfel> <57D963C4.4010406@hisilicon.com>
 <5869118.UilSPY9Sai@wuerfel>
 <2af4f2d8-e3a4-fa00-e700-60af70bf4560@jonmasters.org>
 <6bbfeb57-7a55-6a3e-60b2-3f44525e5882@huawei.com>
 <1475713112.3784.183.camel@kernel.crashing.org>
Message-ID: <3bab676a-2b65-8f27-d414-9cacc055094e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2016 01:18, Benjamin Herrenschmidt wrote:
> On Tue, 2016-10-04 at 13:02 +0100, John Garry wrote:
>> Right, so I think Zhichang can make the necessary generic changes to
>> 8250 OF driver to support IO port as well as MMIO-based.
>>
>> However an LPC-based earlycon driver is still required.
>>
>> A note on hip07-based D05 (for those unaware): this does not use
>> LPC-based uart. It uses PL011. The hardware guys have managed some
>> trickery where they loopback the serial line around the BMC/CPLD. But we
>> still need it for hip06 D03 and any other boards which want to use LPC
>> bus for uart.
>>
>> A question on SBSA: does it propose how to provide serial via BMC for SOL?
>
> Probably another reason to keep 8250 as a legal option ... The (very
> popular) Aspeed BMCs tend to do this via a 8250-looking virtual UART on
> LPC.
>
> Cheers,
> Ben,

I think we're talking about the same thing for our LPC-based UART.

John

>
>
> .
>
