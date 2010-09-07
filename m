From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 09:28:32 +0530
Subject: [PATCH 13/74] ST SPEAr: Update clock framework and definitions
In-Reply-To: <20100906230931.GF8153@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<a15d1fca5a6e663c1fee4602013b6160512eb2dd.1283161023.git.viresh.kumar@st.com>
	<20100906230931.GF8153@game.jcrosoft.org>
Message-ID: <4C85B868.6040908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 4:39 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>  /* array of all spear 13xx clock lookups */
>> > @@ -327,18 +749,58 @@ static struct clk_lookup spear_clk_lookups[] = {
>> >  	/* clock derived from pll1 clk */
>> >  	{.con_id = "cpu_clk",		.clk = &cpu_clk},
>> >  	{.con_id = "ahb_clk",		.clk = &ahb_clk},
>> > -	{ .con_id = "apb_clk",		.clk = &apb_clk},
>> > +	{.con_id = "apb_clk",		.clk = &apb_clk},
>> > +
> how about use macro here to simplify the code
> 
> +#define CLKDEV_ID(__clk) { .con_id = #__clk, .clk = &(__clk) }
> and 
> +#define CLKDEV_ID_CLK(__clk) { .con_id = #__clk, .clk = &(__clk##_clk) }

We had that in mind while designing but we chose it this way. There are
not many fields to fill here, so it looks fine without macro's too.
I didn't wanted to create an abstraction layer here.

>> > diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
>> > index 2e87a07..c4dcab2 100644
>> > --- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
>> > +++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
> how about clock.h header?

If i understand correctly you want me to rename misc_regs.h as clock.h?
Actually misc_regs.h have all miscellaneous registers for spear, like:
clock specific, reset register, some muxing registers too.. They are
not only for "clock". So we kept this name.

viresh.
