From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 16 Feb 2016 10:55:19 +0100
Subject: [PATCH v3 6/7] arm64: dts: r8a7795: Add missing properties to
 CA57 L2 cache node
In-Reply-To: <56C2EF47.4080809@arm.com>
References: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
 <1455568715-20880-7-git-send-email-geert+renesas@glider.be>
 <56C2C471.80000@de.bosch.com> <56C2EF47.4080809@arm.com>
Message-ID: <56C2F207.2080703@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.02.2016 10:43, Sudeep Holla wrote:
>
>
> On 16/02/16 06:40, Dirk Behme wrote:
>> On 15.02.2016 21:38, Geert Uytterhoeven wrote:
>>> Add the missing "cache-unified" and "cache-level" properties to the
>>> Cortex-A57 cache-controller node.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> v3:
>>>    - Remaining part of "[PATCH v2 6/6] arm64: renesas: r8a7795: Add L2
>>>      cache-controller nodes", after dropping the "arm,data-latency" and
>>>      "arm,tag-latency" properties.
>>> ---
>>>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> index b5e46e4ff72ad003..c07f4e83b988ba42 100644
>>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> @@ -68,6 +68,8 @@
>>>
>>>       L2_CA57: cache-controller at 0 {
>>>           compatible = "cache";
>>> +        cache-unified;
>>> +        cache-level = <2>;
>>
>>
>> As this is completely unused on ARMv8 I don't think that we want to have
>> these unused entries in the DT.
>>
>> Sudeep: What do you think?
>>
>
> I am fine with that, I don't see any issue having them as they are
> static values and highly unlikely to change and hence no threat to
> backward compatibility.
>
> The main concern I had with latency values is that it's currently not
> used anywhere but if we decide to use say in secure software, having the
> untested/early values in DT might cause compatibility issues in future
> as they were added much before the actual understanding of it's usage.
> So I prefer to defer them until then.


Fine with me, thanks! :)

With this clarification:

Acked-by: Dirk Behme <dirk.behme@de.bosch.com>


Thanks again and best regards

Dirk
