From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Wed, 26 Sep 2012 13:44:12 +0000
Subject: [linux-keystone] Re: [PATCH v1 01/12] clk: davinci - add Main
 PLL clock driver
In-Reply-To: <CACRpkdbpZ+dxoCq7Ky=EMDR2uDX10vyn3-P+V6iN8mwWCof+HQ@mail.gmail.com>
References: <1348525213-18987-1-git-send-email-m-karicheri2@ti.com>
 <1348525213-18987-2-git-send-email-m-karicheri2@ti.com>
 <CACRpkdbpZ+dxoCq7Ky=EMDR2uDX10vyn3-P+V6iN8mwWCof+HQ@mail.gmail.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041E9CCC@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -----Original Message-----
>> From: Linus Walleij [mailto:linus.walleij at linaro.org]
>> Sent: Wednesday, September 26, 2012 7:11 AM
>> To: Karicheri, Muralidharan
>> Cc: mturquette at linaro.org; arnd at arndb.de; akpm at linux-foundation.org;
>> shawn.guo at linaro.org; rob.herring at calxeda.com; viresh.linux at gmail.com; linux-
>> kernel at vger.kernel.org; Nori, Sekhar; Hilman, Kevin; linux at arm.linux.org.uk; davinci-
>> linux-open-source at linux.davincidsp.com; linux-arm-kernel at lists.infradead.org; linux-
>> keystone at list.ti.com - Linux developers for Keystone family of devices (May contain non-
>> TIers); linux-c6x-dev at linux-c6x.org; Chemparathy, Cyril
>> Subject: [linux-keystone] Re: [PATCH v1 01/12] clk: davinci - add Main PLL clock driver
>> 
>> On Tue, Sep 25, 2012 at 12:20 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
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
>> > +       u32 fixed_prediv;       /* use this value for prediv */
>> > +       u32 pllm_multiplier;    /* multiply PLLM by this factor. By default
>> > +                                * most SOC set this to zero that translates
>> > +                                * to a multiplier of 1 and incrementer of 1.
>> > +                                * To override default, set this factor */
>> > +};
>> 
>> OMG this commenting style hurt my eyes ;-)
>> 
>> Please use good old kerneldoc above the struct instead.
>> 
>> Yours,
>> Linus Walleij

Sure! I will fix these in my next revision.

Murali
