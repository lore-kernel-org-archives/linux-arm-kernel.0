From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 6 May 2015 09:45:15 +0200
Subject: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <4635229.bceBxngCoe@wuerfel>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
 <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
 <4635229.bceBxngCoe@wuerfel>
Message-ID: <5549C68B.9090602@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2015 09:31 AM, Arnd Bergmann wrote:
> On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
>>>> @@ -533,6 +567,16 @@
>>>>                         interrupts = <0x0 0x4f 0x4>;
>>>>                 };
>>>>
>>>> +               sdhc0: sdhc at 1c000000 {
>>>> +                       device_type = "sdhc";
>>>
>>> device_type generally should not be used (there are a few exceptions).
>>
>> Okay !!
>>
> 
> While we're at it, please change sdhc at 1c000000 to mmc at 1c000000.
> Even though Linux does not care, we try to use the standard device
> names for consistency.

Do we have a list of these names somewhere?
Normally I do use ePARP - generic names recommendation but mmc or sdhci
are not listed there.
Both combination mmc@ or sdhci@ are used in the kernel.

On zynq and zynqmp we do use shdci at .

Thanks,
Michal
