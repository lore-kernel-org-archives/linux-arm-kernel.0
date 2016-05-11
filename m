From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 11 May 2016 13:08:00 +0200
Subject: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
Message-ID: <57331290.7070104@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriele,

On 11.05.2016 12:41, Gabriele Paoloni wrote:
> Hi Tomasz
>
>> -----Original Message-----
>> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
>> owner at vger.kernel.org] On Behalf Of Tomasz Nowicki
>> Sent: 10 May 2016 16:20
>> To: helgaas at kernel.org; arnd at arndb.de; will.deacon at arm.com;
>> catalin.marinas at arm.com; rafael at kernel.org; hanjun.guo at linaro.org;
>> Lorenzo.Pieralisi at arm.com; okaya at codeaurora.org; jchandra at broadcom.com
>> Cc: robert.richter at caviumnetworks.com; mw at semihalf.com;
>> Liviu.Dudau at arm.com; ddaney at caviumnetworks.com; Wangyijing;
>> Suravee.Suthikulpanit at amd.com; msalter at redhat.com; linux-
>> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linaro-
>> acpi at lists.linaro.org; jcm at redhat.com; andrea.gallo at linaro.org;
>> dhdang at apm.com; jeremy.linton at arm.com; liudongdong (C);
>> cov at codeaurora.org; Tomasz Nowicki
>> Subject: [PATCH V7 00/11] Support for generic ACPI based PCI host
>> controller
>>
>>  From the functionality point of view this series may be split into the
>> following logic parts:
>> 1. New ECAM API and update for users of the pci-host-common API
>> 2. Necessary fixes as the preparation for using driver on ARM64.
>> 3. Use new MCFG interface and implement generic ACPI based PCI host
>> controller driver.
>> 4. Enable above driver on ARM64
>>
>> Patches has been built on top of 4.6-rc7 and can be found here:
>> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v7)
>>
>> This has been tested on Cavium ThunderX server. Any help in reviewing
>> and
>> testing is very appreciated.
>>
>> v6 -> v7
>> - drop quirks handling
>
> Maybe I missed something in the v6 discussion thread; when was it
> decided to drop quirk handling?

I had such requests in previous series.

>
> I think it is important to have this in place to accommodate different
> vendors. If the intention is to keep this patchset "clean" maybe
> we can add it as a separate patch on top later on...
>
> What?s your view?

Yes, keeping these things separated should help in review. Obviously I 
agree that we need quirk handling but currently there is no 
implementation which we all agree upon. For the test, you can use quirk 
handling approach from the previous series until we sort out final solution.

Thanks,
Tomasz
