From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Aug 2013 15:25:22 -0400
Subject: [PATCH v2 4/6] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <alpine.LFD.2.03.1308030943320.14472@syhkavp.arg>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1308022156120.14472@syhkavp.arg> <51FCFBE1.5090000@ti.com>
 <alpine.LFD.2.03.1308030943320.14472@syhkavp.arg>
Message-ID: <51FD5922.1060705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 03 August 2013 10:01 AM, Nicolas Pitre wrote:
> On Sat, 3 Aug 2013, Sricharan R wrote:
> 
>> On Saturday 03 August 2013 08:58 AM, Nicolas Pitre wrote:
>>> ... meaning that, instead of using 0x81 for the stub value on the mov 
>>> instruction, it only has to be 0x83.  Bits 7 and 0 still act as anchors 
>>> for the rotation field in the opcode, while bit 1 indicates which value 
>>> to patch in.
>>   I started with this kind of augmenting with the immediate operand
>>   while starting V2. But the problem was, we do the runtime patching twice.
> 
> Ahhh... Bummer.
>
Sorry if it wasn't clear but I thought we discussed why patching is
done twice. This was purely based on the discussion where RMK
suggested to follow that approach to minimize code changes.
 
Looks like we need to revisit that now based on Russell's latest
comment.

Regards,
Santosh
