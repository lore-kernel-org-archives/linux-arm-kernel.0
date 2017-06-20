From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 20 Jun 2017 12:02:21 +0200
Subject: [PATCH 1/2] drm/exynos/decon: Add include guard to the Exynos7
 header
In-Reply-To: <CACvgo51db4Gk+GHAO-F=rz8vLTG6A66f1ZeHPNuAQV1Qthaavw@mail.gmail.com>
References: <20170619163110.28173-1-krzk@kernel.org>
 <CACvgo51db4Gk+GHAO-F=rz8vLTG6A66f1ZeHPNuAQV1Qthaavw@mail.gmail.com>
Message-ID: <CAJKOXPfjEozEM=q4hbWRBJngNDxnkJXF37gN2Es1Ju8Qze4J1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 11:53 AM, Emil Velikov <emil.l.velikov@gmail.com> wrote:
> On 19 June 2017 at 17:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Although header is included only once but still having an include guard
>> is a good practice.  To avoid confusion, add SoC prefix to existing
>> Exynos5433 header include guard.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  include/video/exynos5433_decon.h | 6 +++---
>>  include/video/exynos7_decon.h    | 5 +++++
>>  2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/video/exynos5433_decon.h b/include/video/exynos5433_decon.h
>> index 78957c9626f5..b30362da5692 100644
>> --- a/include/video/exynos5433_decon.h
>> +++ b/include/video/exynos5433_decon.h
>> @@ -6,8 +6,8 @@
>>   * published by the Free Software Foundationr
>>   */
>>
>> -#ifndef EXYNOS_REGS_DECON_H
>> -#define EXYNOS_REGS_DECON_H
>> +#ifndef EXYNOS5433_REGS_DECON_H
>> +#define EXYNOS5433_REGS_DECON_H
>>
> Drop the _REGS_ part from the guard on each header? The file name/path
> does not have it, plus it'll save some WTF moments when
> exynos{5433,7}_regs_decon.h comes about.

So maybe it makes sense to reorder these patches and use the guard
name matching final file name?

Best regards,
Krzysztof
