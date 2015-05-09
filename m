From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 9 May 2015 09:42:45 +0900
Subject: ARM: EXYNOS: Fixes for 4.1
In-Reply-To: <554CFFEB.1010703@kernel.org>
References: <1430873718-22726-1-git-send-email-k.kozlowski@samsung.com>
 <554CFFEB.1010703@kernel.org>
Message-ID: <CAJKOXPfXX5s-hubOESKU7b=-Akg1aWkqMUEUM5fqm6y397tRFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-09 3:26 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
> On 05/06/15 09:55, Krzysztof Kozlowski wrote:
>> Krzysztof Kozlowski (1):
>>       ARM: EXYNOS: Fix failed second suspend on Exynos4
>>
>>  arch/arm/mach-exynos/common.h  |  2 ++
>>  arch/arm/mach-exynos/exynos.c  | 27 +++++++++++++++++++++++++++
>>  arch/arm/mach-exynos/platsmp.c | 39 ++-------------------------------------
>>  arch/arm/mach-exynos/suspend.c |  3 +++
>>  4 files changed, 34 insertions(+), 37 deletions(-)
>> --
>
> Hi Krzysztof,
>
> Yeah, the patch is old thing but if I remember correctly, I couldn't
> apply it because of soc_is_xxx() macro. Yes, I agree with the way,
> firstly fix something and if required, then update it later....But!
>
> Please address comments about that, if not, it will not be accepted by
> arm-soc tree.

Hi,

Actually during previous discussion I addressed all the issues:
https://lkml.org/lkml/2015/3/18/108
but there was no response from your side.

In previous thread you also asked about proper way of using the
DELAYED_RESET_ASSERTION. I tried to obtain additional docs from LSI
but couldn't. In current documentation it was described vaguely so I
looked at vendor source code. The patch IMHO is the best solution.
Additionally it was tested (Chanwoo and Bartlomiej) and fixes the
issue.

As for the soc_is_exynos -> of_machine_is_compatible I will prepare a
follow up to fix this.

Let me know if you have any other comments about it.

Best regards,
Krzysztof
