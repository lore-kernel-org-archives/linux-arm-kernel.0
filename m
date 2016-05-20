From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 20 May 2016 16:48:26 +0530
Subject: [PATCH V4 6/7] iommu/msm: Use writel_relaxed and add a barrier
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
 <3070591.xyl7SB8DB7@wuerfel> <002c01d1b0fd$e4f3c350$aedb49f0$@codeaurora.org>
 <2638968.1a16UdaY62@wuerfel>
Message-ID: <001301d1b289$58e56f70$0ab04e50$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

>>
>>If you need the barrier after the write, it probably was already faulty
>>before, because writel only implies a barrier before the store, not
>>after. Of course all the barriers likely made the whole process so
>>slow that you never hit that race in the end.
>
>ya, it could have worked in this way and i never saw a race issue before this.
>The only reason for changing this was to optimise out the additonal barriers
>that were happening. I do not see any issue now as well, only that the writes would
>be faster.
>
 I reposted a patch here [1] with comments, i had to delete the
old accessors though as it became unused now.

http://www.spinics.net/lists/arm-kernel/msg505448.html

Regards,
 Sricharan
