From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 14 Apr 2014 22:16:10 -0700
Subject: [PATCH] PM / devfreq: Use freq_table for available_frequencies
In-Reply-To: <8568895.444151397525760132.JavaMail.weblogic@epml02>
References: <8568895.444151397525760132.JavaMail.weblogic@epml02>
Message-ID: <534CC09A.30200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2014 06:36 PM, ??? wrote:
>> MyungJoo/Kyungmin,
>>
>> Bump. Can we accept this patch please?
>>
>> -Saravana
> 
> Nack.
> 
> Please note that freq_table is also an optional value, which may
> be null.

Ah, I saw that the max_freq would be zero if freq_table was NULL and I
assumed that it can't be NULL. But I see that the max_freq limit is not
applied if it's zero. Thanks for catching it.

> Besides, please be aware that your code is under rcu_read_lock().

Valid point. I was just trying to keep the diff simple. No one's really
going to be catting this file often when performance matters.

> 
> 
> Cheers,
> MyungJoo.
> 
> ps. I'll send a related patch (avoid accessing null but not-an-error
> pointer at other sysfs nodes). Thank you for letting me catch such bugs anyway.

I can go ahead and do this myself if you don't mind.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
