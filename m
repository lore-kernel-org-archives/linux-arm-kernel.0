From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 03 Mar 2014 16:35:52 -0800
Subject: [PATCH] PM / devfreq: Rewrite devfreq_update_status() to fix
 multiple bugs
In-Reply-To: <1393558737-24037-1-git-send-email-skannan@codeaurora.org>
References: <1393558737-24037-1-git-send-email-skannan@codeaurora.org>
Message-ID: <53151FE8.70703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2014 07:38 PM, Saravana Kannan wrote:
> The current devfreq_update_status() has the following bugs:
> - If previous frequency doesn't have a valid level, it does an out of bounds
>    access into the trans_table and causes memory corruption.
> - When the new frequency doesn't have a valid level, the time spent in the
>    new frequency is counted towards the next valid frequency switch instead of
>    being ignored.
> - The time spent on the previous frequency is added to the new frequency's
>    stats instead of the previous frequency's stats.
>
> This patch fixes all of this.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---

MyungJoo/Kyungmin,

Can you please take a look and let me know if this looks ok? Any 
possibility of getting this into 3.14?

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
