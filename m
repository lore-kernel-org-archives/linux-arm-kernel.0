From: jian.hu@amlogic.com (Jian Hu)
Date: Mon, 16 Jul 2018 13:58:58 +0800
Subject: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
In-Reply-To: <1531316752.2708.113.camel@baylibre.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com>
 <454887b2-6d29-4fe9-ee34-400363671746@amlogic.com>
 <1531316752.2708.113.camel@baylibre.com>
Message-ID: <d00bfbac-a041-3dc9-0cda-9a6eef5f3216@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome

On 2018/7/11 21:45, Jerome Brunet wrote:
> On Wed, 2018-07-11 at 21:41 +0800, Jian Hu wrote:
>>>>>> +static struct clk_regmap g12a_mpll0 = {
>>>>>> +       .data = &(struct clk_regmap_gate_data){
>>>>>> +               .offset = HHI_MPLL_CNTL1,
>>>>>> +               .bit_idx = 31,
>>>>>> +       },
>>>>>> +       .hw.init = &(struct clk_init_data){
>>>>>> +               .name = "mpll0",
>>>>>> +               .ops = &clk_regmap_gate_ops,
>>>>>> +               .parent_names = (const char *[]){ "mpll0_div" },
>>>>>> +               .num_parents = 1,
>>>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>>>> +       },
>>>>>> +};
>>>
>>> The previous had a predivider (1 or 2) in front of these mpll. Even if the
>>> predivider is usually set to be a passthrough, it is better to model the tree
>>> correctly.
>>>
>>> Is this SoC any different ?
>>>
>>
>> I am not sure the difference, I will confirm with IC design guys.
> 
> I suggest that you have a look at the (upstream) axg and gxbb clock driver for
> this
> 
> Same goes for the fdiv gates.
> 
> Last, please trim your replies a bit. It will make easier to see what you are
> replying to.
> 
> .
> 

I have confirmed with IC design guys, axg and gxbb clock driver have a 
prediver in frount  of these mpll, according to the Spec, we can get the 
prediver function in HHI_MPLL_CNTL5 bit12, the G12A SoC have not the 
prediver function.
