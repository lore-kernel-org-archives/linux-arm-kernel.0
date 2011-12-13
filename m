From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 13 Dec 2011 14:16:13 +0530
Subject: [PATCH 3/4] ARM: smp_twd: get the rate from a clock
In-Reply-To: <20111213081723.GB14542@n2100.arm.linux.org.uk>
References: <1323683847-23902-1-git-send-email-linus.walleij@stericsson.com>
 <4EE6E17E.5040902@ti.com> <20111213081723.GB14542@n2100.arm.linux.org.uk>
Message-ID: <CAMQu2gyauDsYE+MK56iKhrVBgvOU8Z3Hbtfxd-G_ZmQUBAW4LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 1:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 13, 2011 at 10:54:14AM +0530, Santosh Shilimkar wrote:
>> > +static struct clk *twd_get_clock(void)
>> > +{
>> > + ? struct clk *clk;
>> > + ? int err;
>> > +
>> > + ? clk = clk_get_sys("smp_twd", NULL);
>>
>> As noticed by Mike, would be better to use con_id instead
>> of dev_id here. I mean,
>> clk = clk_get_sys(NULL, "smp_twd");
>
> Why? ?It makes more sense for a device ID to be passed for this.
Sorry. I assumed clk_get_sys() signature same as clk_get(). And then
thought dev pointer and con_id is the right way to go about it.
Since clk_get_sys() directly takes dev_id, it should be fine.

Will update OMAP clock-node patch accordingly.

Regards
Santosh
