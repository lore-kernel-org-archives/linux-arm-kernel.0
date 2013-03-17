From: rmallon@gmail.com (Ryan Mallon)
Date: Sun, 17 Mar 2013 11:06:29 +1100
Subject: ep93xx irq-vic regression
In-Reply-To: <201303161449.03823.florian@openwrt.org>
References: <ADE657CA350FB648AAC2C43247A983F0020980106C9F@AUSP01VMBX24.collaborationhost.net>
 <5143AAB4.6020406@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F0020980106CB7@AUSP01VMBX24.collaborationhost.net>
 <201303161449.03823.florian@openwrt.org>
Message-ID: <51450905.8030108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/13 00:49, Florian Fainelli wrote:

> Hello,
> 
> Le samedi 16 mars 2013 01:16:52, H Hartley Sweeten a ?crit :
> [snip]
> 
>>
>>     ARM: ep93xx: properly wait for UART FIFO to be empty
>>
>> Reverting that one allows my system to boot with 3.9.0-rc2.
>>
>> Instead of removing the wait loop completely I propose this
>> patch instead. I can repost this patch in a new thread if
>> necessary.
>>
>> Regards,
>> Hartley
>>
>> ---
>>
>> From: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Subject: [PATCH] arm: ep93xx: fix wait for UART FIFO to be empty
>>
>> commit 210dce5f "ARM: ep93xx: properly wait for UART FIFO to be empty"
>>
>> Removed the timeout loop while waiting for the uart transmit fifo to
>> empty. Some bootloaders leave the uart in a state where there might
>> be bytes in the uart that are not transmitted when execution is handed
>> over to the kernel. This results in a deadlocked system while waiting
>> for the fifo to empty.
>>
>> Add back the timeout wait to prevent the deadlock.
>>
>> Increase the wait time to hopefully prevent the decompressor corruption
>> that lead to commit 210dce5f. This corruption was probably due to a
>> slow uart baudrate. The 10* increase in the wait time should be enough
>> for all cases.
> 
> Ok, your solution seems like it would work, when I come accross this bug I 
> initially ended up doing the same thing and incrementing the number of 
> iterations in the loop. I was not quite happy with that as it would still be 
> highly depending on the clocking. Anyway, sorry for breaking your system with 
> this commit.


Do you want to add an Acked/Reviewed-by Florian? I'll queue this
up in my tree if you are happy with it.

~Ryan
