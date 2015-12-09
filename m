From: dirk.behme@gmail.com (Dirk Behme)
Date: Wed, 9 Dec 2015 17:58:38 +0100
Subject: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
In-Reply-To: <20151208191656.GD11797@leverpostej>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com> <20151207190355.GE28024@leverpostej>
 <5667267E.2080601@gmail.com> <20151208191656.GD11797@leverpostej>
Message-ID: <56685DBE.8030001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.12.2015 20:16, Mark Rutland wrote:
> On Tue, Dec 08, 2015 at 07:50:38PM +0100, Dirk Behme wrote:
>> On 07.12.2015 20:03, Mark Rutland wrote:
>>> On Mon, Dec 07, 2015 at 06:49:43PM +0000, Sudeep Holla wrote:
>>>>
>>>> On 07/12/15 18:24, Geert Uytterhoeven wrote:
>>>>> +	L2_CA57: cache-controller at 0 {
>>>>> +		compatible = "cache";
>>>>> +		arm,data-latency = <4 4 1>;
>>>>> +		arm,tag-latency = <3 3 3>;
>>>>
>>>> Interesting, only PL2xx/3xx cache controller driver reads this from the
>>>> DT and configures the controller. The integrated L2 found in
>>>> A15/A7/A57/A53 needs doesn't make use of these values from the DT.
>>>
>>> These properties seem to be from l2cc.txt, which really only corresponds
>>> to PL210/PL220/PL310 (and variants) and isn't as generic as it sounds.
>>>
>>> I don't see that these are necessary at all.
>>
>>
>> What's about a documentation patch like [1], then?
>
> I think it would be better to s/l2cc/l2x0/, and to make it clear that
> the document only applies to the variants listed above.
>
> If ePAPR doesn't cover the other cases, we should document those
> separately.


Ok, thanks, I'll have a look to it.


>> For what is the arm64 dts entry
>>
>> cpu at 0 {
>> 	...
>> 	next-level-cache = <&L2_0>;
>> };
>>
>> L2_0: l2-cache0 {
>> 	compatible = "cache";
>> };
>>
>> good for at all, then?
>
> With the other properties from ePAPR you can acquire information on the
> geometry of the cache, which cannot be acquired from architected
> registers.


Just for my understanding: Yes, if other properties from ePAPR like 
geometry of the cache are added to the device tree l2 cache entries 
then it makes sense to have them.

But an "empty" entry like the one given in the example above doesn't 
make much sense and could be removed without loosing any functionality?

It looks to me that most of the L2 entries we have in 
arch/arm64/boot/dts are such "empty" entries.

Is this understanding correct?

Best regards

Dirk
