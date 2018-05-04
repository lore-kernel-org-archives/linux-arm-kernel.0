From: opensource.ganesh@gmail.com (Ganesh Mahendran)
Date: Fri, 4 May 2018 14:05:06 +0800
Subject: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
In-Reply-To: <20180502122314.GB30246@arm.com>
References: <1525247602-1565-1-git-send-email-opensource.ganesh@gmail.com>
 <20180502122314.GB30246@arm.com>
Message-ID: <CADAEsF86bXkK3qjJTKR6aqEEp_ch6HqSHeDy3afZF0wcVPFPRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-05-02 20:23 GMT+08:00 Will Deacon <will.deacon@arm.com>:
> On Wed, May 02, 2018 at 03:53:21PM +0800, Ganesh Mahendran wrote:
>> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
>> enables Speculative Page Fault handler.
>
> Are there are tests for this? I'm really nervous about enabling it...

Hi, Will

I test the arm64 spf on Qcom SDM845 cpu with kernel 4.9.
It looks good for performance, and have not found stability issue yet.

Thanks.

>
> Will
>
>>
>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>> ---
>> This patch is on top of Laurent's v10 spf
>> ---
>>  arch/arm64/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index eb2cf49..cd583a9 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -144,6 +144,7 @@ config ARM64
>>       select SPARSE_IRQ
>>       select SYSCTL_EXCEPTION_TRACE
>>       select THREAD_INFO_IN_TASK
>> +     select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP
>>       help
>>         ARM 64-bit (AArch64) Linux support.
>>
>> --
>> 1.9.1
>>
