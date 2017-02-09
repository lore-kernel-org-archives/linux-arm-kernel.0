From: webczat_200@poczta.onet.pl (=?UTF-8?Q?Micha=c5=82_Zegan?=)
Date: Thu, 9 Feb 2017 13:51:11 +0100
Subject: [PATCH 1/2] clk: scpi: RfC - Allow to ignore invalid SCPI DVFS
 clock rates
In-Reply-To: <6c360b3c-629c-03ea-3332-545da38ba283@arm.com>
References: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
 <d7b8f9db-7512-646c-bb96-ef74e7266661@gmail.com>
 <209248b8-2a1c-e00f-d8a8-b82759772b5d@arm.com> <m28tpgihzw.fsf@baylibre.com>
 <efe61325-eacd-2d4d-3ac0-71d54ef9d2bb@arm.com>
 <f0c0ed0a-82d5-4814-3420-bae9aa65193b@poczta.onet.pl>
 <6c360b3c-629c-03ea-3332-545da38ba283@arm.com>
Message-ID: <f7e65721-bf09-54ed-a5d3-c918b0ca4505@poczta.onet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



W dniu 09.02.2017 o 13:25, Sudeep Holla pisze:
> 
> 
> On 09/02/17 12:19, Micha? Zegan wrote:
>>
>>
>> W dniu 09.02.2017 o 11:52, Sudeep Holla pisze:
>>>
>>>
>>> On 08/02/17 19:45, Kevin Hilman wrote:
>>>> Sudeep Holla <sudeep.holla@arm.com> writes:
>>>>
>>>>> On 04/02/17 21:03, Heiner Kallweit wrote:
>>>>>> Introduce an optional property "clock-max-frequency" for SCPI DVFS
>>>>>> clocks. All frequencies for the respective clock exceeding this
>>>>>> threshold will be ignored.
>>>>>>
>>>>>> This is useful on systems where the firmware offers too optimistic
>>>>>> clock rates causing instabilities and crashes.
>>>>>>
>>>>>
>>>>> It clearly means the firmware/hardware(IOW platform) was not tested
>>>>> correctly before firmware advertised the OPPs. It needs to fixed in the
>>>>> firmware. The approach should be advertise the known minimal set working
>>>>> rather than the set for which hardware was designed.
>>>>>
>>>>> That's the whole reason while these are kept in firmware so the OS need
>>>>> not worry about such details.
>>>>>
>>>>> So NACK, go fix the firmware 
>>>>
>>>> Sorry, but "go fix the firmware" is not an option for most users of
>>>> these boards.
>>>>
>>>
>>> I knew this was coming :). I just wanted to shout at vendors who are not
>>> validating their firmware. Sometimes I feel it's better have platform
>>> driver and drive everything from Linux and don't use buggy firmware at
>>> all instead of adding tons of workaround. It defeats the whole purpose
>>> of having the firmware.
>>>
>> Well, at least in the case of odroid c2 from hardkernel, I believe those
>> unstable frequencies are supported intentionally. The wiki of the board
>> lists them explicitly, and says when they are stable.
>> So if that was intentional, then a frequency capping set by default
>> would be needed, it can be lifted by a specific user if he wants. Unless
>> hk should disable that "feature" instead.
> 
> If those frequency are known to cause any stability issues, they should
> be considered as *not supported*. If it's just thermal constraints then
> yes the user/developer should be allowed to use them as they can take
> care of thermal management so that the platform remains stable for usage.
> 
The unstability does not occur when you do not use all cores at once, so hmm

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 525 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170209/a7e428bb/attachment.sig>
