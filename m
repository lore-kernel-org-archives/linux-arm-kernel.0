From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 16 May 2013 10:35:39 +0100
Subject: [PATCH v3 2/4] clk: add support for clock reparent on set_rate
In-Reply-To: <5193EF34.7070800@codeaurora.org>
References: <1368625263-23136-1-git-send-email-james.hogan@imgtec.com>
 <1368625263-23136-3-git-send-email-james.hogan@imgtec.com>
 <5193EF34.7070800@codeaurora.org>
Message-ID: <5194A86B.6000207@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/13 21:25, Stephen Boyd wrote:
> On 05/15/13 06:41, James Hogan wrote:
>> Each place where round_rate() is called, determine_rate is checked first
>> and called in preference, passing NULL to the new parent argument if not
>> needed (e.g. in __clk_round_rate).
> 
> That's annoying. Even if we don't care about the pointer in
> clk_round_rate(), this requires the ops to check for NULL before
> assigning the pointer. Why not just pass an unused pointer that the ops
> can assign all the time?

True, I'll fix that.

> With the above change you can add
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks for taking the time to review it.

Cheers
James
