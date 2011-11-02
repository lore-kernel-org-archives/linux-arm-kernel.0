From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 2 Nov 2011 18:37:19 +0530
Subject: [PATCH v2] gpio/samsung: Add device tree support for Exynos4
In-Reply-To: <004d01cc9956$46ef8040$d4ce80c0$%kim@samsung.com>
References: <1320108227-2693-1-git-send-email-thomas.abraham@linaro.org>
	<004d01cc9956$46ef8040$d4ce80c0$%kim@samsung.com>
Message-ID: <CAJuYYwRrku+7u_Ws4_c99xP3tWXG9ewj=sULchwcQK2_sdPnJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mr. Kim,

On 2 November 2011 17:25, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> As gpio chips get registered, a device tree node which represents the
>> gpio chip is searched and attached to it. A translate function is also
>> provided to convert the gpio specifier into actual platform settings
>> for pin function selection, pull up/down and driver strength settings.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> Changes since v1:
>> - As suggested by Rob and Grant, the gpio controller node lookup is based
>> ? on the base address of the gpio controller instead of the unique
>> ? per-controller compatible property value.
>>
>> This patch is based on the following tree and branch.
>> git://git.linaro.org/git/people/arnd/arm-soc.git ?branch: for-next
>>
>> ?.../devicetree/bindings/gpio/gpio-samsung.txt ? ? ?| ? 40 ++++++++++++
>> ?drivers/gpio/gpio-samsung.c ? ? ? ? ? ? ? ? ? ? ? ?| ? 66
>> ++++++++++++++++++++
>> ?2 files changed, 106 insertions(+), 0 deletions(-)
>> ?create mode 100644

[...]

>> diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
>> index 8662518..0140756 100644
>> --- a/drivers/gpio/gpio-samsung.c
>> +++ b/drivers/gpio/gpio-samsung.c

[...]

> Thomas,
>
> Happens following build error.
>
> drivers/gpio/gpio-samsung.c: In function 'samsung_gpiolib_init':
> drivers/gpio/gpio-samsung.c:2519: error: 'EXYNOS4_PA_GPIO1' undeclared
> (first use in this function)
> drivers/gpio/gpio-samsung.c:2519: error: (Each undeclared identifier is
> reported only once
> drivers/gpio/gpio-samsung.c:2519: error: for each function it appears in.)
> drivers/gpio/gpio-samsung.c:2533: error: 'EXYNOS4_PA_GPIO2' undeclared
> (first use in this function)
> drivers/gpio/gpio-samsung.c:2547: error: 'EXYNOS4_PA_GPIO3' undeclared
> (first use in this function)

Can this be fixed while you apply this patch. If required, I can
submit an updated patch for this.

Thanks,
Thomas.

>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
