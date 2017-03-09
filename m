From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 09 Mar 2017 09:29:40 +0100
Subject: linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681:
 suspicious mask ?
In-Reply-To: <58C10571.9050107@samsung.com>
References: <CGME20170306100527epcas1p349cea73e30f7720a65d312808c4b2cc3@epcas1p3.samsung.com>
 <DB5PR08MB0967CD7B84545DE129126A619C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
 <58C10571.9050107@samsung.com>
Message-ID: <4809303a-ab12-6246-63b5-b92e928eae2a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.03.2017 08:34, Inki Dae wrote:
> Hello David,
>
> Thanks for report.
>
> 2017? 03? 06? 19:05? David Binderman ?(?) ? ?:
>> Hello there,
>>
>> linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681]: (warning) Result of operator '|' is always true if one operand is non-zero. Did you intend to use '&'?
>>
> Right. this is known issue and below patch fixes this,
> http://www.spinics.net/lists/dri-devel/msg132589.html
>
> This patch will go to -fixes.
>
>> Source code is
>>
>>     if (ctx->out_type | I80_HW_TRG) {
>>
>> Also in the same file:
>>
>> [drivers/gpu/drm/exynos/exynos5433_drm_decon.c:131]: (style) Same expression on both sides of '|'.
>>
>> Source code is
>>
>>        writel(TRIGCON_TE_AUTO_MASK | TRIGCON_SWTRIGEN
>>                | TRIGCON_TE_AUTO_MASK | TRIGCON_SWTRIGEN,
> In this case, only problem is two flags are set in duplicate. This should be cleaned up. Thanks. :)

Wrong copy/paste removed two other flags and duplicated these above. It
did not hurt to much as it affects only software trigger which is not
used atm.
Fix sent yesterday [1].

[1]: http://www.spinics.net/lists/dri-devel/msg134877.html

Regards
Andrzej

>
>> Regards
>>
>> David Binderman
>>
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
