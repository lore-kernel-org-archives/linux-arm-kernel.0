From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 08:27:47 -0600
Subject: [PATCH v2 1/7] OMAP2: hwmod data: add mailbox data
In-Reply-To: <4CD58BAA.8020909@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-2-git-send-email-omar.ramirez@ti.com>
	<4CD58BAA.8020909@ti.com>
Message-ID: <AANLkTi=wx-Nr7S1iWK2K__XZtEmE2pKNkejtFbsae+X5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Benoit,

On Sat, Nov 6, 2010 at 12:08 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> +/* l4_core -> ?mailbox */
>> +static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
>> + ? ? ? .master ? ? ? ? =&omap2420_l4_core_hwmod,
>> + ? ? ? .slave ? ? ? ? ?=&omap2420_mailbox_hwmod,
>> + ? ? ? .addr ? ? ? ? ? = omap2420_mailbox_addrs,
>> + ? ? ? .clk ? ? ? ? ? ?= "mailboxes_ick",
>
> Could you try to be consistent with the omap4 format? it is easier to diff
> between Soc version: .clk is before .addr

In all the randomness of how the data files look, I didn't now omap4
was the standard. For this one, I tried to follow the
"omap_hwmod_ocp_if" structure definition where 'clk' is the 4th member
of that structure.

I'll change it to mimic omap4 looks...

>> +static struct omap_hwmod omap2420_mailbox_hwmod = {
>> + ? ? ? .name ? ? ? ? ? = "mailbox",
>> + ? ? ? .class ? ? ? ? ?=&omap2420_mailbox_hwmod_class,
>> + ? ? ? .prcm ? ? ? ? ? = {
>> + ? ? ? ? ? ? ? .omap2 = {
>> + ? ? ? ? ? ? ? ? ? ? ? .prcm_reg_id = 1,
>> + ? ? ? ? ? ? ? ? ? ? ? .module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
>> + ? ? ? ? ? ? ? ? ? ? ? .module_offs = CORE_MOD,
>> + ? ? ? ? ? ? ? ? ? ? ? .idlest_reg_id = 1,
>> + ? ? ? ? ? ? ? ? ? ? ? .idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
>> + ? ? ? ? ? ? ? },
>> + ? ? ? },
>
> Same things with the format, put that after irqs_cnt and before slaves.

more or less the same, since 'prcm' was above in the definition order
I kept it a bit up of where it is supposed to be.

I'll change it too

>> @@ -569,6 +635,7 @@ static __initdata struct omap_hwmod *omap2420_hwmods[]
>> = {
>> ? ? ? ?&omap2420_uart3_hwmod,
>> ? ? ? ?&omap2420_i2c1_hwmod,
>> ? ? ? ?&omap2420_i2c2_hwmod,
>
> Add a blank line between each class. OK it was not done for i2c, but it
> should.
>
> All the comments are applicable to the 2430 and 3430 data as well.

Will do.

Thanks for your comments,

Omar
