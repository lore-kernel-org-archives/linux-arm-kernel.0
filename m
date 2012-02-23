From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Thu, 23 Feb 2012 10:44:33 -0600
Subject: [PATCH] ARM: OMAP2: fix mailbox init code
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317AD2B7@DBDE01.ent.ti.com>
References: <1329987215-28227-1-git-send-email-ohad@wizery.com>
 <B5906170F1614E41A8A28DE3B8D12143317AD2B7@DBDE01.ent.ti.com>
Message-ID: <CAB-zwWhBzbLLH7CDvUG_aaTfkMsK-iYZRG=FLHpjJQFZvYmxiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 23, 2012 at 3:18 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> On Thu, Feb 23, 2012 at 14:23:35, Ohad Ben-Cohen wrote:
> [...]
>>
>> Which happens on CONFIG_ARCH_OMAP2 && !CONFIG_SOC_OMAP2420, due to
>> missing omap2_mboxes declaration.
>>
> [...]
>>
>> -struct omap_mbox *omap2_mboxes[] = { &mbox_dsp_info, &mbox_iva_info, NULL };
>> +#ifdef CONFIG_ARCH_OMAP2
>> +struct omap_mbox *omap2_mboxes[] = {
>> + ? ? &mbox_dsp_info,
>> +#ifdef CONFIG_SOC_OMAP2420
>> + ? ? &mbox_iva_info,
>> +#endif
>> + ? ? NULL
>> +};
>> ?#endif
>>
>> ?#if defined(CONFIG_ARCH_OMAP4)
>
> Instead of adding more #ifs can they be completely removed please?

I'll rebase/repost this series:

[PATCH 0/7] OMAP: mailbox: removing static declarations
http://comments.gmane.org/gmane.linux.ports.arm.omap/59620

In the meantime I would appreciate comments.

Regards,

Omar
