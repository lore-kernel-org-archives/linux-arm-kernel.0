From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Fri, 16 Jan 2015 19:50:18 +0800
Subject: [PATCH v5 4/5] arm64: Add support for Spreadtrum's Sharkl64
 Platform in Kconfig and defconfig
In-Reply-To: <20150116104842.GE21809@leverpostej>
References: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-5-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150116104842.GE21809@leverpostej>
Message-ID: <CAAfSe-vuSgwH2PHQdYLyfJ+KZ0C8a7D6Ry=mHaBrjpbuksaKvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark

On Fri, Jan 16, 2015 at 6:48 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jan 16, 2015 at 10:00:10AM +0000, Chunyan Zhang wrote:
>> From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
>>
>> Adds support for Spreadtrum's SoC Platform in the arm64 Kconfig and
>> defconfig files.
>>
>> Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
>> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  arch/arm64/Kconfig           |    5 +++++
>>  arch/arm64/configs/defconfig |    1 +
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b1f9a20..885c1f4 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -153,6 +153,11 @@ config ARCH_SEATTLE
>>       help
>>         This enables support for AMD Seattle SOC Family
>>
>> +config ARCH_SPRD
>
> This should presumably be ARCH_SHARKL64, so you can add other SoC
> families later. The other entries in here are already formatted that
> way.
>
> I wonder if we should have these of the form ARCH_${VENDOR}_${FAMILY}
> (e.g. ARCH_SPRD_SHARKL64) rather than just ARCH_${FAMILY} to save
> ourselves from name conflicts in future (and to make it easier to grep
> for a particular vendor's config options).
>

actually we've discussed this question before[1], and I think Arnd's
suggestion is suitable for our case, so I changed this to use
ARCH_SPRD instead of ARCH_SHARKL64.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306246.html

anyway, thank you very much!

Chunyan

>> +     bool "Spreadtrum SoC platform"
>
> bool "Spreadtrun Sharkl64 SoC Family"
>
>> +     help
>> +       Support for Spreadtrum ARM based SoCs
>
>
> Support for the Spreadtrum Sharkl64 SoC family.
>
> Thanks,
> Mark.
>
>> +
