From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 23 Mar 2012 14:39:53 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <4F6CEC0C.4060704@codeaurora.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <20120320140220.GE32469@S2101-09.ap.freescale.net>
 <efca11f1b68186dbf1771c09fe3a2f0a.squirrel@www.codeaurora.org>
 <CAJOA=zNmgSQfYAUZ-vqqTk0w3s3eKz3tjVOpyDgO35Q_Ogkz0g@mail.gmail.com>
 <4F6946AA.4070201@codeaurora.org> <4F6CEC0C.4060704@codeaurora.org>
Message-ID: <CAJOA=zNDKesFtuRgv+6brmBvmbQQecKEOJ89EiG-+YzXVTosWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 2:33 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 03/20/2012 08:10 PM, Saravana Kannan wrote:
>>
>> On 03/20/2012 04:53 PM, Turquette, Mike wrote:
>>>
>>> It does make me
>>> wonder if it would be a good idea to pass in the parent rate for
>>> .set_parent, which is analogous to .set_rate in many ways.
>>
>>
>> I need to think a bit more about this.
>
>
> I was thinking about this. I think the common clock fwk should let the
> set_parent ops "return" the rate of the clock in addition to passing the
> rate of the parent in.
>
> Say this is a divider clock and some one changes the parent. The cached
> "rate" of the clock in the clock fwk is no longer correct. So, the clock fwk
> should also add a "*new_rate" param to set parent ops.

__clk_recalc_rates is called by __clk_reparent which is called by
clk_set_parent.  __clk_recalc_rates is also called by clk_set_rate.

Does this not handle the old cached clk->rate for you?

Thanks,
Mike

>
> Thanks,
>
> Saravana
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
