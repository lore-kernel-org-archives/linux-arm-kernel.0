From: kishorek.kadiyala@gmail.com (kishore kadiyala)
Date: Fri, 24 Sep 2010 21:54:36 +0530
Subject: [PATCH v3 2/4] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is
	not set
In-Reply-To: <4C9A457B.4060500@ru.mvista.com>
References: <14880.10.24.255.18.1285173821.squirrel@dbdmail.itg.ti.com>
	<4C9A457B.4060500@ru.mvista.com>
Message-ID: <AANLkTikADtXK=+vi_r9c7XHbwt1UjZoJv2VndmbJEqau@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 11:35 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> kishore kadiyala wrote:
>
>> From: Benoit Cousson <b-cousson@ti.com>
>
>> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set
>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> ?arch/arm/mach-omap2/board-4430sdp.c | ? ?8 +++++++-
>> ?1 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
>> b/arch/arm/mach-omap2/board-4430sdp.c
>> index a49f285..ac8541c 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -240,8 +240,14 @@ static int omap4_twl6030_hsmmc_late_init(struct
>> device *dev)
>>
>> ?static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
>> ?{
>> - ? ? ? struct omap_mmc_platform_data *pdata = dev->platform_data;
>> + ? ? ? struct omap_mmc_platform_data *pdata;
>>
>> + ? ? ? /* dev can be null if CONFIG_MMC_OMAP_HS is not set */
>> + ? ? ? if (!dev) {
>> + ? ? ? ? ? ? ? pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
>
> ? pr_err("Failed %s\n", __func__);

OK , will have as mentioned
>
> WBR, Sergei

Regards,
Kishore
