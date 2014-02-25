From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 25 Feb 2014 13:13:56 -0800
Subject: [PATCH] PM / devfreq: Fix out of bounds access of transition
 table array
In-Reply-To: <1393226100-18428-1-git-send-email-skannan@codeaurora.org>
References: <1393226100-18428-1-git-send-email-skannan@codeaurora.org>
Message-ID: <530D0794.2080405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2014 11:15 PM, Saravana Kannan wrote:
> The previous_freq value for a device could be an invalid frequency that
> results in a error value being returned from devfreq_get_freq_level().
> Check for an error value before using that to index into the transition
> table.
>
> Not doing this check will result in memory corruption when previous_freq is
> not a valid frequency.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>

MyungJoo/Kyungmin,

Would either of you have some time to respond to this?

Thanks,
Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
