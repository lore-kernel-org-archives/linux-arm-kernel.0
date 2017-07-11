From: slash.tmp@free.fr (Mason)
Date: Tue, 11 Jul 2017 13:56:03 +0200
Subject: cpufreq: frequency scaling spec in DT node
In-Reply-To: <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
 <20170711102514.GC17115@vireshk-i7>
 <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
Message-ID: <3095a4bb-39d0-5d91-e6e8-b39811e24ec1@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2017 13:09, Mason wrote:
> On 11/07/2017 12:25, Viresh Kumar wrote:
>> On 11-07-17, 11:27, Mason wrote:
>>> On 29/06/2017 16:34, Viresh Kumar wrote:
>>>
>>>> On 29-06-17, 13:41, Mason wrote:
>>>>
>>>>> I'm on SoC B, where nominal/max freq is expected to be 1206 MHz.
>>>>> So the OPPs in the DT are:
>>>>> operating-points = <1206000 0 603000 0 402000 0 241200 0 134000 0>;
>>>>> *But* FW changed the max freq behind my back, to 1215 MHz.
>>
>> What does this line mean really? Where is this frequency changed?
>> In the OPP table in DT?
> 
> I apologize for being unclear.
> 
> What I meant is that the bootloader originally set the max frequency
> to 1206 MHz. The OPP table in DTS was written based on that value.
> 
> Later, someone changed the bootloader code to set a slightly higher
> max frequency. When I flashed the new bootloader on my board, the
> OPP table no longer matches the actual frequency.
> 
> But I am not notified when bootloader authors change max frequencies,
> which is why I wrote "changed the max freq behind my back".
> 
> Again, sorry for the confusing statements.
> 
> (The bootloader is not DT-aware, so it leaves the DT untouched.)

I just realized that there's another unstated assumption.

Since the bootloader is not DT-aware, the DTB is, in fact, appended
to the kernel image. This is why it's possible to have "mismatching"
kernel and bootloader.

Regards.
