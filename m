From: robherring2@gmail.com (Rob Herring)
Date: Tue, 18 Sep 2012 07:50:04 -0500
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for
 clean and flush range
In-Reply-To: <alpine.LFD.2.02.1209171827260.28681@xanadu.home>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
 <1347890398-22088-1-git-send-email-robherring2@gmail.com>
 <20120917194733.GQ12245@n2100.arm.linux.org.uk> <5057881A.9020604@gmail.com>
 <alpine.LFD.2.02.1209171827260.28681@xanadu.home>
Message-ID: <50586DFC.9000902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2012 05:31 PM, Nicolas Pitre wrote:
> On Mon, 17 Sep 2012, Rob Herring wrote:
> 
>> On 09/17/2012 02:47 PM, Russell King - ARM Linux wrote:
>>> Plus, because there's little justification behind this patch (apart
>>> from a vague reference to the speed of IO accesses) I'm going to say
>>> NAK to this until further information is forthcoming justifying this
>>> change.
>>>
>>
>> 30% faster network transmit rate with pktgen on highbank.
> 
> Please always include your benchmark results in the patch description. 
> That is highly valuable information when looking at commit logs.
> 

Agreed as it would now be helpful if the original optimization to use
background ops had some data as well:

    ARM: l2x0: Optimise the range based operations

    For the big buffers which are in excess of cache size, the maintaince
    operations by PA are very slow. For such buffers the maintainace
    operations can be speeded up by using the WAY based method.

    Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Acked-by: Catalin Marinas <catalin.marinas@arm.com>
    Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Rob
