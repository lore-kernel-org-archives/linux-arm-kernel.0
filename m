From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 08 May 2013 20:50:24 -0700
Subject: [PATCH v2 0/3] clk: implement remuxing during set_rate
In-Reply-To: <518AE16D.5060501@codeaurora.org>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <518AE16D.5060501@codeaurora.org>
Message-ID: <518B1D00.5030700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2013 04:36 PM, Stephen Boyd wrote:
> On 04/19/13 09:28, James Hogan wrote:
>> This patchset adds support for automatic selection of the best parent
>> for a clock mux, i.e. the one which can provide the closest clock rate
>> to that requested. It can be controlled by a new CLK_SET_RATE_REMUX flag
>> so that it doesn't happen unless explicitly allowed.
>>
>> This works by way of adding a new op, determine_rate, similar to
>> round_rate but with an extra parameter to allow the clock driver to
>> optionally select a different parent clock. This is used in
>> clk_calc_new_rates to decide whether to initiate a set_parent operation.
>
> Which tree is this based on? I get failures with git am on patch 2.
>

Mike's clk-for-3.10 branch.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
