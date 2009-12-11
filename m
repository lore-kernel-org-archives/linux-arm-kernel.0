From: nm@ti.com (Nishanth Menon)
Date: Fri, 11 Dec 2009 10:37:02 -0600
Subject: [PATCH 1/6 v2] OMAP4: Fix cpu detection
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC1415B4@dbde02.ent.ti.com>
References: <1260426156-1820-1-git-send-email-santosh.shilimkar@ti.com>
	<4B2156B6.8090403@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BC1415B4@dbde02.ent.ti.com>
Message-ID: <782515bb0912110837i732250f2m4f50246594973b67@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 10:43 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> >
>> > +void __init omap4_check_revision(void)
>> > +{
>> > + ? u32 idcode;
>> > + ? u16 hawkeye;
>> > + ? u8 rev;
>> > + ? char *rev_name = "ES1.0";
>> should'nt you decide this inside the rev check path?
>
> This is initialized value by default. Since the chip is ES1.0 additionaly I am not doing it.
> e.g. for ES2.0, it would be done inside. > > +
ok, no strong opinions about this, but I think it might be nice if
ES2.0 addition will modify less code.

>> > + ? /*
>> > + ? ?* The IC rev detection is done with hawkeye and rev.
>> > + ? ?* Note that rev does not map directly to defined processor
>> > + ? ?* revision numbers as ES1.0 uses value 0.
>> > + ? ?*/
>> > + ? idcode = read_tap_reg(OMAP_TAP_IDCODE);
>> > + ? hawkeye = (idcode >> 12) & 0xffff;
>> > + ? rev = (idcode >> 28) & 0xff;
>> > +
>> > + ? if ((hawkeye == 0xb852) && (rev == 0x0)) {
>> > + ? ? ? ? ? omap_revision = OMAP4430_REV_ES1_0;
>> > + ? ? ? ? ? pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
>> wondering about the >>16 part.
> Why ?
omap_rev() >>16 means that you are using higher word of this and I
think we have CLASS() macro for that? if that is not enough, should'nt
we add adequate macro to do that?

[...]

Regards,
Nishanth Menon
