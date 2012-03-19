From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 19 Mar 2012 12:53:50 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <4F6716DD.5090900@ti.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <4F6716DD.5090900@ti.com>
Message-ID: <CAJOA=zMPrf-JH_Pmzvkb==1Ew0g4oVS2L=ecJE3WxXsJ4GWkgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 4:22 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 16 March 2012 11:41 AM, Mike Turquette wrote:
>> +/*
>> + * calculate the new rates returning the topmost clock that has to be
>> + * changed.
>> + */
>> +static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long
>> rate)
>> +{
>> + ? ? ? struct clk *top = clk;
>> + ? ? ? unsigned long best_parent_rate = clk->parent->rate;
>
>
> Shouldn't you check for a valid parent before dereferencing it? A
> clk_set_rate() on a root clock might throw up some issues otherwise.

Yes, the clk_calc_new_rates code assumes a valid parent pointer in
several locations.  Thanks for the catch.  Will roll into my fixes
series.

Regards,
Mike
