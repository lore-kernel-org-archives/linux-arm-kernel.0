From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 12 Oct 2011 22:00:11 +0530
Subject: [PATCH 2/3] ARM: Exynos4: Add ioremap interceptor for statically
	remapped regions
In-Reply-To: <4E95BC8E.8010105@gmail.com>
References: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
	<1318234289-22041-3-git-send-email-thomas.abraham@linaro.org>
	<4E95BC8E.8010105@gmail.com>
Message-ID: <CAJuYYwSQgiZMEuzyqFvijy+sTLWqi=TqvM8cGe=W3bPOSBe0Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2011 21:43, Rob Herring <robherring2@gmail.com> wrote:
> On 10/10/2011 03:11 AM, Thomas Abraham wrote:
>> ioremap() request for statically remapped regions are intercepted and the
>> statically assigned virtual address is returned. For requests for which
>> there are no statically remapped regions, the requests are let through.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/mach-exynos4/cpu.c ? ? ? ? ? ? | ? 16 ++++++++++++++++
>> ?arch/arm/mach-exynos4/include/mach/io.h | ? ?4 ++++
>> ?2 files changed, 20 insertions(+), 0 deletions(-)
>>
>
> You won't need this with Nico's vmalloc.h clean-up series. It does
> exactly this but generically for all platforms.

Ok. Thanks for your suggestion. I will move to using Nico's patches.

Regards,
Thomas.

>
> Rob
>
