From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 14 May 2010 13:47:06 +0300
Subject: [PATCH 03/15] omap: mailbox: 2420 should be detected at run-time
In-Reply-To: <4BED2326.4090302@ru.mvista.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
	<1273772856-10881-4-git-send-email-felipe.contreras@gmail.com>
	<4BED2326.4090302@ru.mvista.com>
Message-ID: <AANLkTimcw0MNZdXjM6K6HJw02qlmggXqeQXHG64HYyUX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 14, 2010 at 1:17 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Felipe Contreras wrote:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> ?arch/arm/mach-omap2/mailbox.c | ? ?3 ++-
>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
>> index 252e53b..6d17da8 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -431,7 +431,8 @@ err_dsp:
>> ?static int __devexit omap2_mbox_remove(struct platform_device *pdev)
>> ?{
>> ?#if defined(CONFIG_ARCH_OMAP2420)
>> - ? ? ? omap_mbox_unregister(&mbox_iva_info);
>> + ? ? ? if (cpu_is_omap2420())
>> + ? ? ? ? ? ? ? omap_mbox_unregister(&mbox_iva_info);
>> ?#endif
>
> ? Shouldn't #ifdef be remove then?

My first patch did that, but now mbox_iva_info is only available when
ARCH_OMAP2420=y to save space when building for a specific OMAP.

-- 
Felipe Contreras
