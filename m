From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 08 Feb 2017 11:45:39 -0800
Subject: [PATCH 1/2] clk: scpi: RfC - Allow to ignore invalid SCPI DVFS
 clock rates
In-Reply-To: <209248b8-2a1c-e00f-d8a8-b82759772b5d@arm.com> (Sudeep Holla's
 message of "Wed, 8 Feb 2017 11:23:47 +0000")
References: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
 <d7b8f9db-7512-646c-bb96-ef74e7266661@gmail.com>
 <209248b8-2a1c-e00f-d8a8-b82759772b5d@arm.com>
Message-ID: <m28tpgihzw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> On 04/02/17 21:03, Heiner Kallweit wrote:
>> Introduce an optional property "clock-max-frequency" for SCPI DVFS
>> clocks. All frequencies for the respective clock exceeding this
>> threshold will be ignored.
>> 
>> This is useful on systems where the firmware offers too optimistic
>> clock rates causing instabilities and crashes.
>> 
>
> It clearly means the firmware/hardware(IOW platform) was not tested
> correctly before firmware advertised the OPPs. It needs to fixed in the
> firmware. The approach should be advertise the known minimal set working
> rather than the set for which hardware was designed.
>
> That's the whole reason while these are kept in firmware so the OS need
> not worry about such details.
>
> So NACK, go fix the firmware 

Sorry, but "go fix the firmware" is not an option for most users of
these boards.

Even if the source were provided for the firwmare (it's not), it usually
needs signing by the vendor, and we know how likely that will be
provided by the vendors.

Firmware will will always be buggy and/or broken and we will be stuck
with it.  IMO, not allowing the kernel to work around broken
firmwaretakes a very idealistic view of firmware, and is not based on
historical reality with ARM SoC vendors.

> or disable it completely and be happy with the boot frequency.

That's an awful solution also, when we know that most of the frequencies
work just fine.

Kevin
