From: lho@apm.com (Loc Ho)
Date: Thu, 29 May 2014 11:54:52 -0700
Subject: [PATCH 1/3] Documentation: Update Arasan SDHC documentation for
 the APM X-Gene SoC SDHC DTS binding
In-Reply-To: <20140519123230.GA3663@leverpostej>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
 <1400398918-1502-2-git-send-email-lho@apm.com>
 <20140519123230.GA3663@leverpostej>
Message-ID: <CAPw-ZTn_gN4k24JcWWnMSi5LgRdRm30=-BsNSVmx6ymN-2=GFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 98ee2ab..8fc4cc4 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -8,14 +8,17 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>
>>  Required Properties:
>> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>> +                'xgene,arasan,sdhci-8.9a'
>
> "xgene" is not a vendor, nor is it documented as such.

I will change to "apm".

>
>>    - reg: From mmc bindings: Register location and length.
>> -  - clocks: From clock bindings: Handles to clock inputs.
>> -  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>>    - interrupts: Interrupt specifier
>>    - interrupt-parent: Phandle for the interrupt controller that services
>>                     interrupts for this device.
>>
>> +Optional Properties:
>> +  - clocks: From clock bindings: Handles to clock inputs.
>> +  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>
> Given that these used to be required, they are presumably still required
> in some cases?

>From the driver point of view, it is optional as it no longer requires
this. But from usage point of view, if an HW requires this to work
correctly, then it musts be provided.

>
> If we're going to alter these lines, it'd be nice to clean them up at
> the same time (a list is not a tuple, clocks aren't just phandles).
>

I will update this.

-Loc
