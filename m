From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Fri, 28 Sep 2012 20:12:43 +0000
Subject: [linux-keystone] Re: [PATCH 01/13] clk: davinci - add Main PLL
 clock driver
In-Reply-To: <CACRpkdZ=8m+X2KnUPFFhT2LsvTe-jPR_m6oVt_CEFfY-LvFHmg@mail.gmail.com>
References: <1348682889-9509-1-git-send-email-m-karicheri2@ti.com>
 <1348682889-9509-2-git-send-email-m-karicheri2@ti.com>
 <CACRpkdZ=8m+X2KnUPFFhT2LsvTe-jPR_m6oVt_CEFfY-LvFHmg@mail.gmail.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041EF93B@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -----Original Message-----
>> From: Linus Walleij [mailto:linus.walleij at linaro.org]
>> Sent: Thursday, September 27, 2012 9:20 AM
>> To: Karicheri, Muralidharan
>> Cc: mturquette at linaro.org; arnd at arndb.de; akpm at linux-foundation.org;
>> shawn.guo at linaro.org; rob.herring at calxeda.com; viresh.linux at gmail.com; linux-
>> kernel at vger.kernel.org; Nori, Sekhar; Hilman, Kevin; linux at arm.linux.org.uk; davinci-
>> linux-open-source at linux.davincidsp.com; linux-arm-kernel at lists.infradead.org; linux-
>> keystone at list.ti.com - Linux developers for Keystone family of devices (May contain non-
>> TIers); linux-c6x-dev at linux-c6x.org; Chemparathy, Cyril
>> Subject: [linux-keystone] Re: [PATCH 01/13] clk: davinci - add Main PLL clock driver
>> 
>> On Wed, Sep 26, 2012 at 8:07 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>> 
>> > +struct clk_davinci_pll_data {
>> > +       /* physical addresses set by platform code */
>> > +       u32 phy_pllm;
>> > +       /* if PLL has a prediv register this should be non zero */
>> > +       u32 phy_prediv;
>> > +       /* if PLL has a postdiv register this should be non zero */
>> > +       u32 phy_postdiv;
>> > +       /* mapped addresses. should be initialized by  */
>> > +       void __iomem *pllm;
>> > +       void __iomem *prediv;
>> > +       void __iomem *postdiv;
>> > +       u32 pllm_mask;
>> > +       u32 prediv_mask;
>> > +       u32 postdiv_mask;
>> > +       u32 num;
>> > +       /* framework flags */
>> > +       u32 flags;
>> > +       /* pll flags */
>> > +       u32 pll_flags;
>> > +       /* use this value for prediv */
>> > +       u32 fixed_prediv;
>> > +       /* multiply PLLM by this factor. By default most SOC set this to zero
>> > +        * that translates to a multiplier of 1 and incrementer of 1.
>> > +        * To override default, set this factor
>> > +        */
>> > +       u32 pllm_multiplier;
>> > +};
>> > +
>> 
>> No, that's not what I meant.
>> 
>> I meant like this:
>> 
>> /**
>>  * struct clk_davinci_pll_data - struct holding the PLL data
>>  * phy_pllm: physical addresses set by platform code
>>  * phy_prediv: ...
>> (...)
>>  */
>> struct clk_davinci_pll_data {
>>       u32 phy_pllm;
>>       u32 phy_prediv;
>> (...)
>> };
>> 
Ok. Will do in the next revision.

Murali Karicheri
Software Design Engineer

>> Yours,
>> Linus Walleij
