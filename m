From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 04 Mar 2014 12:25:24 -0800
Subject: [PATCH] PM / devfreq: Rewrite devfreq_update_status() to fix
 multiple bugs
In-Reply-To: <8984550.302431393927576253.JavaMail.weblogic@epv6ml05>
References: <8984550.302431393927576253.JavaMail.weblogic@epv6ml05>
Message-ID: <531636B4.1060202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 02:06 AM, MyungJoo Ham wrote:
>> The current devfreq_update_status() has the following bugs:
>> - If previous frequency doesn't have a valid level, it does an out of bounds
>>    access into the trans_table and causes memory corruption.
>> - When the new frequency doesn't have a valid level, the time spent in the
>>    new frequency is counted towards the next valid frequency switch instead of
>>    being ignored.
>> - The time spent on the previous frequency is added to the new frequency's
>>    stats instead of the previous frequency's stats.
>>
>> This patch fixes all of this.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> 
> Merged.
> 
> It appears to be Greg's LTS material as well.
> 

Thanks!

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
