From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 09 May 2013 12:48:41 -0700
Subject: [PATCH v2 0/3] clk: implement remuxing during set_rate
In-Reply-To: <518B663D.60806@imgtec.com>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <518AE16D.5060501@codeaurora.org> <518B663D.60806@imgtec.com>
Message-ID: <518BFD99.2010208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/13 02:02, James Hogan wrote:
> On 09/05/13 00:36, Stephen Boyd wrote:
>> On 04/19/13 09:28, James Hogan wrote:
>>> This patchset adds support for automatic selection of the best parent
>>> for a clock mux, i.e. the one which can provide the closest clock rate
>>> to that requested. It can be controlled by a new CLK_SET_RATE_REMUX flag
>>> so that it doesn't happen unless explicitly allowed.
>>>
>>> This works by way of adding a new op, determine_rate, similar to
>>> round_rate but with an extra parameter to allow the clock driver to
>>> optionally select a different parent clock. This is used in
>>> clk_calc_new_rates to decide whether to initiate a set_parent operation.
>> Which tree is this based on? I get failures with git am on patch 2.
>>
> It was based on v3.9-rc4.
>

Thanks. Would it be possible for you to update to Mike's for-next
branch? I've done the rebase myself for now and it seems to work well
enough. I'll need to add the set_rate_and_parent() op on top.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
