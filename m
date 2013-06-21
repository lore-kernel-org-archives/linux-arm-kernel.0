From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 21 Jun 2013 22:27:16 +0100
Subject: [PATCH v5 0/5] clk: implement remuxing during set_rate
In-Reply-To: <20130621170407.20448.35605@quantum>
References: <1371139562-305-1-git-send-email-james.hogan@imgtec.com>
 <20130621170407.20448.35605@quantum>
Message-ID: <CAAG0J9-F0P67=oaE5UHhmgd3Wz4k4XjsRjWShxmKOqicAyrhfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2013 18:04, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting James Hogan (2013-06-13 09:05:57)
>> This patchset adds support for automatic selection of the best parent
>> for a clock mux, i.e. the one which can provide the closest clock rate
>> to that requested. It can be disabled by a new CLK_SET_RATE_NO_REPARENT
>> flag (which is set for all uses of clk_register_mux().
>>
>> This works by way of adding a new op, determine_rate, similar to
>> round_rate but with an extra parameter to allow the clock driver to
>> optionally select a different parent clock. This is used in
>> clk_calc_new_rates to decide whether to initiate a set_parent operation.
>
> Hi James,
>
> I'm going to hold off on this one for 3.11. I'll revisit it after the
> next merge window.

Okay, no worries.

Thanks
James
