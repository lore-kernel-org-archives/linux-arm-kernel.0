From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 9 Feb 2017 10:52:53 +0000
Subject: [PATCH 1/2] clk: scpi: RfC - Allow to ignore invalid SCPI DVFS
 clock rates
In-Reply-To: <m28tpgihzw.fsf@baylibre.com>
References: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
 <d7b8f9db-7512-646c-bb96-ef74e7266661@gmail.com>
 <209248b8-2a1c-e00f-d8a8-b82759772b5d@arm.com> <m28tpgihzw.fsf@baylibre.com>
Message-ID: <efe61325-eacd-2d4d-3ac0-71d54ef9d2bb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/17 19:45, Kevin Hilman wrote:
> Sudeep Holla <sudeep.holla@arm.com> writes:
> 
>> On 04/02/17 21:03, Heiner Kallweit wrote:
>>> Introduce an optional property "clock-max-frequency" for SCPI DVFS
>>> clocks. All frequencies for the respective clock exceeding this
>>> threshold will be ignored.
>>>
>>> This is useful on systems where the firmware offers too optimistic
>>> clock rates causing instabilities and crashes.
>>>
>>
>> It clearly means the firmware/hardware(IOW platform) was not tested
>> correctly before firmware advertised the OPPs. It needs to fixed in the
>> firmware. The approach should be advertise the known minimal set working
>> rather than the set for which hardware was designed.
>>
>> That's the whole reason while these are kept in firmware so the OS need
>> not worry about such details.
>>
>> So NACK, go fix the firmware 
> 
> Sorry, but "go fix the firmware" is not an option for most users of
> these boards.
> 

I knew this was coming :). I just wanted to shout at vendors who are not
validating their firmware. Sometimes I feel it's better have platform
driver and drive everything from Linux and don't use buggy firmware at
all instead of adding tons of workaround. It defeats the whole purpose
of having the firmware.

> Even if the source were provided for the firmware (it's not), it
> usually needs signing by the vendor, and we know how likely that will
> be provided by the vendors.
> 

I agree, but the main reason for raising my voice is to communicate the
message to those vendors. Blindly accepting whatever they give is also
not a good practice.

> Firmware will will always be buggy and/or broken and we will be
> stuck with it.  IMO, not allowing the kernel to work around broken 
> firmware takes a very idealistic view of firmware, and is not based
> on historical reality with ARM SoC vendors.
> 

Yes but things should start to improve somewhere sometime. It really
stupid to keep working around everything vendor screws up giving them no
incentive to get things right the next time. We need to accept the fact
that firmware will do more as the complex systems evolve and that won't
go away. It's time we make them aware of that and ensure they take
necessary steps to fix it for future platforms.

>> or disable it completely and be happy with the boot frequency.
> 
> That's an awful solution also, when we know that most of the
> frequencies work just fine.
> 

OK, I understand the concern. I will look into the patches.

-- 
Regards,
Sudeep
