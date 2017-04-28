From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 28 Apr 2017 14:05:48 -0400
Subject: [PATCH v2 1/3] ARM: BCM: Enable thermal support for iProc SoCs
In-Reply-To: <bceb9b66-c769-faf3-9288-26581b5d5dc6@broadcom.com>
References: <1493328194-1766-1-git-send-email-jon.mason@broadcom.com>
 <1493328194-1766-2-git-send-email-jon.mason@broadcom.com>
 <bceb9b66-c769-faf3-9288-26581b5d5dc6@broadcom.com>
Message-ID: <CAC3K-4omn1A5ddPhkhhROLmtcEDJjHg7boa0B=c9OUuAHV6NyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 7:10 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
>
>
> On 17-04-27 02:23 PM, Jon Mason wrote:
>>
>> Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
>> the ns-thermal driver to be selected via menuconfig.
>>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> ---
>>  arch/arm/mach-bcm/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index a0e66d8..da2bfeb 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
>>         select GPIOLIB
>>         select ARM_AMBA
>>         select PINCTRL
>> +       select THERMAL
>> +       select THERMAL_OF
>
> This is NSP specific at this point.  Also, If it increases code size in any
> way it shouldn't be selected for all IPROC SoCS.  I'd rather this was just
> selected via defconfig

This isn't selectable via menuconfig without being in the kconfig.
I'll move it to the NSP portion of the kconfig, as to not increase the
size of other's kernels.

Thanks,
Jon

>
>>         help
>>           This enables support for systems based on Broadcom IPROC
>> architected SoCs.
>>           The IPROC complex contains one or more ARM CPUs along with
>> common
>>
>
