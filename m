From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 11 Nov 2018 19:57:51 +0000
Subject: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable
 binding
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
 <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com>
 <20181109114818.GB30658@n2100.armlinux.org.uk>
 <CAK8P3a26XmBpG3VzwUgSdd_Xo_S2ezSvA9mjKckRFr9p38j-dg@mail.gmail.com>
Message-ID: <a07fead828b8452bb37708180dd721d4@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/18 4:58 AM, Arnd Bergmann wrote:
> On Fri, Nov 9, 2018 at 12:48 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>>
>> On Fri, Nov 09, 2018 at 12:40:06PM +0100, Arnd Bergmann wrote:
>>> On Fri, Nov 9, 2018 at 8:04 AM Chris Packham
>>> <chris.packham@alliedtelesis.co.nz> wrote:
>>>>
>>>> Add documentation for the marvell,ecc-enable and marvell,ecc-disable
>>>> properties which can be used to enable/disable ECC on the Marvell aurora
>>>> cache.
>>>>
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>> ---
>>>
>>> Why do you need both enable and disable? Wouldn't one of them be enough here?
>>
>> It isn't an "on when ecc-enable is present, off when not" because the
>> current behaviour is to preserve these bits in the control register.
>>
>> If we were to implement it as "if no ecc-enable property, turn off
>> ECC" then that would drastically change the behaviour - systems which
>> were configured for ECC suddenly lose ECC support.
>>
>> Since we don't know which have it and which don't, we can't implement
>> the option like that.
> 
> What I meant was why we need support force-disabling it. I understand
> that we need to allow leaving it at the boot-time default as well as
> force-enabling it.

I added ecc-disable because I was modeling it after 
arm,parity-enable/arm,parity-disable. The only reason I can imagine 
wanting to force disable this would be some mis-behaving SoC which has 
it enabled by default in hardware, to my knowledge no such system exists 
(that would use this driver).

I'd be happy to drop the binding an implementation and send a v7 if you 
feel strongly that it marvell,ecc-disable should be removed.
