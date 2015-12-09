From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 9 Dec 2015 17:34:45 +0000
Subject: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
In-Reply-To: <20151209172127.GA24353@leverpostej>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com> <20151207190355.GE28024@leverpostej>
 <5667267E.2080601@gmail.com> <20151208191656.GD11797@leverpostej>
 <56685DBE.8030001@gmail.com> <20151209172127.GA24353@leverpostej>
Message-ID: <56686635.8030104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/12/15 17:21, Mark Rutland wrote:
> On Wed, Dec 09, 2015 at 05:58:38PM +0100, Dirk Behme wrote:
>>>> For what is the arm64 dts entry
>>>>
>>>> cpu at 0 {
>>>> 	...
>>>> 	next-level-cache = <&L2_0>;
>>>> };
>>>>
>>>> L2_0: l2-cache0 {
>>>> 	compatible = "cache";
>>>> };
>>>>
>>>> good for at all, then?
>>>
>>> With the other properties from ePAPR you can acquire information on the
>>> geometry of the cache, which cannot be acquired from architected
>>> registers.
>>
>>
>> Just for my understanding: Yes, if other properties from ePAPR like
>> geometry of the cache are added to the device tree l2 cache entries
>> then it makes sense to have them.
>>
>> But an "empty" entry like the one given in the example above doesn't
>> make much sense and could be removed without loosing any
>> functionality?
>>
>> It looks to me that most of the L2 entries we have in
>> arch/arm64/boot/dts are such "empty" entries.
>>
>> Is this understanding correct?
>
> You are mostly correct, just missing some history.
>
> It was previously (erroneously) assumed that the cache geometry could be
> derived from architected registers used for set/way maintenance.
> However, we knew that this did not describe how those caches were linked
> to each other (e.g. which CPU shared with level x cache). So the
> description in DT was required to provide that.
>
> Now, we all know that the geometry is necessary too. Those DTs should be
> fixed.
>
> Sudeep, do you know what's happening on that front?
>

No updates yet. I thought Alex Van Brunt would pick that. I have a patch
for PPC which never got tested/reviewed. It moves PPC code to reuse the
generic cacheinfo. If I can revive that and look into ways of moving it
to core code.

-- 
Regards,
Sudeep
