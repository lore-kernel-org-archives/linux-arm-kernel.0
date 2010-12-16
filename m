From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Thu, 16 Dec 2010 11:01:53 -0600
Subject: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc
	handling
In-Reply-To: <AANLkTinJOFMF=eC2MQB92e2XUsyyjNRRz7Bm_cyXEmp6@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
	<AANLkTinJOFMF=eC2MQB92e2XUsyyjNRRz7Bm_cyXEmp6@mail.gmail.com>
Message-ID: <AANLkTik6GLJkhyg0t77wQrfA6p-SmWXLFfGci0uskJ43@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 16, 2010 at 10:32 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
>> @@ -130,12 +120,6 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
>> ? ? ? ?l = mbox_read_reg(MAILBOX_REVISION);
>> ? ? ? ?pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
>>
>> - ? ? ? if (cpu_is_omap44xx())
>> - ? ? ? ? ? ? ? l = OMAP4_SMARTIDLE;
>> - ? ? ? else
>> - ? ? ? ? ? ? ? l = SMARTIDLE | AUTOIDLE;
>> - ? ? ? mbox_write_reg(l, MAILBOX_SYSCONFIG);
>> -
>
> The OMAP4 mailbox sysconfig register bits are laid out differently
> from previous OMAP mailbox's. Example is smart idle bit location is
> different from previous OMAPs. Can I know as how are you handling this
> aspect in hwmod code ?

hwmod framework provides definition for both IP models
(omap_hwmod_sysc_type1for omap2/3 or omap_hwmod_sysc_type2 for omap4),
these are located at arch/arm/mach-omap2/omap_hwmod_common_data.c

Regards,

Omar
