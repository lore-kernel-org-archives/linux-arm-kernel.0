From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Aug 2012 17:31:46 +0200
Subject: [RFC 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <20120810152036.GK2066@mudshark.cambridge.arm.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
 <1344438307-8468-4-git-send-email-gregory.clement@free-electrons.com>
 <20120808151946.GE4579@mudshark.cambridge.arm.com>
 <50229422.40305@free-electrons.com> <50229944.60603@free-electrons.com>
 <20120810144922.GH2066@mudshark.cambridge.arm.com>
 <50252525.8050602@free-electrons.com>
 <20120810152036.GK2066@mudshark.cambridge.arm.com>
Message-ID: <50252962.5090107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 05:20 PM, Will Deacon wrote:
> On Fri, Aug 10, 2012 at 04:13:41PM +0100, Gregory CLEMENT wrote:
>> On 08/10/2012 04:49 PM, Will Deacon wrote:
>>> Can the Armada 370 be configured to use the co-processor interface to the
>>> L2, or does only the Armada XP support that feature? What happens if you
>>> build a single zImage supporting both of the SoCs?
>>
>> About L2 cache we already use the same kernel on Armada 370 and Armada XP
>> and the differences are in the device tree.
> 
> Right, but I wonder whether you can end up using both the outer_cache
> functions *and* the co-processor interface on the Armada XP by accident.

Well from what I know it should be possible to have both in the same time.
However we implement the support in a way that you won't have both in the
same time: if we use the "system cache" mode then we don't use any outer_cache
functions.

> Ideally, we'd just use the co-processor interface on all platforms and
> ignore the memory-mapped one. Is that possible on the 370?
> 
The 370 can't use the "system cache" mode (ie the co-processor).


__________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
