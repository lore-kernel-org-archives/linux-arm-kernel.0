From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 15 Feb 2010 20:51:42 +0200
Subject: [PATCH] iop: n2100: enable serial interrupt
In-Reply-To: <20100214215432.GB1637@mail.wantstofly.org>
References: <1266184405-21444-1-git-send-email-aaro.koskinen@iki.fi>
	<20100214215432.GB1637@mail.wantstofly.org>
Message-ID: <54963A80-C8CC-49FB-BD4C-1509B4964CD9@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14.2.2010, at 23.54, Lennert Buytenhek wrote:
> On Sun, Feb 14, 2010 at 11:53:25PM +0200, Aaro Koskinen wrote:
>
>> Thecus N2100 has a jumper (J3/J4) to select whether the XINT1  
>> interrupt
>> line is connected to the second UHCI controller (position J3) or to
>> the serial port UART (position J4). Currently, the kernel is  
>> hardcoded
>> to assume the J3 position, and the serial port is always being  
>> used in
>> polling mode.
>>
>> The patch adds the IRQ autodetection flag for the serial port  
>> interrupt,
>> and also marks it as shared (as the driver for the second UHCI  
>> controller
>> will request the interrupt in any case). Now, when the jumper is  
>> set to
>> the J4 position, the serial port will have an interrupt line,  
>> resulting
>> in less CPU overhead and faster throughput.
>>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>
> Assuming that you've found this to actually work:
>
> Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>


Yes, it works, I'm using 2.6.32.8 kernel with this patch. Both jumper  
positions
work as expected.

A.
