From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 6 May 2015 14:41:54 +0200
Subject: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <2568634.iEosTvMJpM@wuerfel>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <4635229.bceBxngCoe@wuerfel> <5549C68B.9090602@xilinx.com>
 <2568634.iEosTvMJpM@wuerfel>
Message-ID: <554A0C12.7080702@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2015 10:40 AM, Arnd Bergmann wrote:
> On Wednesday 06 May 2015 09:45:15 Michal Simek wrote:
>> On 05/06/2015 09:31 AM, Arnd Bergmann wrote:
>>> On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
>>>>>> @@ -533,6 +567,16 @@
>>>>>>                         interrupts = <0x0 0x4f 0x4>;
>>>>>>                 };
>>>>>>
>>>>>> +               sdhc0: sdhc at 1c000000 {
>>>>>> +                       device_type = "sdhc";
>>>>>
>>>>> device_type generally should not be used (there are a few exceptions).
>>>>
>>>> Okay !!
>>>>
>>>
>>> While we're at it, please change sdhc at 1c000000 to mmc at 1c000000.
>>> Even though Linux does not care, we try to use the standard device
>>> names for consistency.
>>
>> Do we have a list of these names somewhere?
>> Normally I do use ePARP - generic names recommendation but mmc or sdhci
>> are not listed there.
>> Both combination mmc@ or sdhci@ are used in the kernel.
>>
>> On zynq and zynqmp we do use shdci at .
>>
> 
> Ah, I thought ePAPR listed mmc already. Using "sdhci" is a little too
> specific here, since a lot of mmc hosts are not sdhci compliant, and
> "sdhc" is completely wrong, because that identifies a specific card
> type, but a host that supports SDHC cards will generally also work
> with SD (less than 4GB) or SDXC (more than 48GB) cards.

Yes "sdhc" is completely wrong.

Based on our datasheet(also version used on Zynq and ZynqMP) this IP is
compliant with SD HC 3.00, SDIO 3.0, SD MC 3.01 SD MCS 1.01, MMC 4.51.
Not sure about the version which they use.
Also not sure which spec the IP should have to be able to say that we
can use sdhci name. Do you have exact SPEC name?

Thanks,
Michal
