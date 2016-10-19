From: sophian.yoma@gmail.com (yoma sophian)
Date: Wed, 19 Oct 2016 15:18:34 +0800
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <95484b8f-58de-3588-ac91-5ec21e66ab05@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
 <20161018104539.GB15639@leverpostej>
 <95484b8f-58de-3588-ac91-5ec21e66ab05@arm.com>
Message-ID: <CADUS3okR8n-Xp+knQJMGNkNd7jVJLb6ZRoMaxRrWsHo2aGgqKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Sudeep:

2016-10-18 18:59 GMT+08:00 Sudeep Holla <sudeep.holla@arm.com>:
>
>
> On 18/10/16 11:45, Mark Rutland wrote:
>>
>> On Tue, Oct 18, 2016 at 12:00:02PM +0200, Pavel Machek wrote:
>>>>>
>>>>> b. in arm64, if some platform has its own suspend flow,  couldn't it
>>>>> adopts arm/match-xxx to register its own global suspend method?
>>>>
>>>>
>>>> No, PSCI is highly recommended.
>>>
>>>
>>> Relying on firmware for suspend on x86 was a great disaster, lets not
>>> repeat
>>> that mistake. arm32 has better powermanagement than x86 ever will (see
>>> Nokia N900
>>> for example) -- feel free to copy that code from arm32.
>>
>>
>> Quite frankly, copying hundreds of lines of board-specific code
>> (including assembly that won't compile) is unlikely to help.
>>
>> So far arm64 requires well-defined, standard, reusable interfaces (e.g.
>> PSCI). That cleanly separates concerns (e.g. anyone can implement the
>> backend without mandatory changes to the kernel), and keeps things
>> maintainable.
>>
>> ARM publishes and maintains the ARM Trusted Firmware [1], which anyone
>> can use and build atop of. It's open source (three-clause BSD with DCO),
>> and accepts board ports. You can have a completely open stack,
>> regardless of whether part of that stack is firmware.
>>
>
> I think you missed to add the link[1]
> [1] https://github.com/ARM-software/arm-trusted-firmware
thanks for your kind information ^^
