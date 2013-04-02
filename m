From: agraf@suse.de (Alexander Graf)
Date: Tue, 02 Apr 2013 13:45:39 +0200
Subject: [PATCH 3/3] ARM: EXYNOS5250: Register architected timers
In-Reply-To: <239701ce2f8f$093a2f40$1bae8dc0$%kim@samsung.com>
References: <1363222742-15220-1-git-send-email-agraf@suse.de>
 <1363222742-15220-4-git-send-email-agraf@suse.de>
 <239701ce2f8f$093a2f40$1bae8dc0$%kim@samsung.com>
Message-ID: <515AC4E3.2070508@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 12:44 PM, Kukjin Kim wrote:
> Alexander Graf wrote:
>> When running on an exynos 5250 SoC, we don't initialize the architected
>> timers. The chip however supports architected timers.
>>
> Yes, exynos5250 can support, mct(multi core timer) is used though.
>
>> When we don't initialize them, KVM will try to access them and run into
>> NULL pointer dereferences attempting to do so.
>>
> Yes, right.
>
>> This patch is really more of a hack than a real fix, but does get me
>> working with KVM on Arndale.
>>
> Hmm, if you think, this is _really_ a hack, you need to add some comments
> about that for clearance, and since the mct.c file has been moved into
> drivers/clocksource/, this should be re-worked.
>
> BTW, I discussed about this with Thomas and Giridhar just now, we reached
> this 3rd patch could be dropped because the correct way is to add a dts
> node for arch timer which patch 2nd is already doing after 3.9-rc1 because
> of CLOCKSOURCE_OF_DECLARE macro.
>
> So if you' OK above, let me know so that I can take only 1st and 2nd
> patches to support KVM on exynos5250.

I'd say go ahead and take them and I'll verify whether things work on
your tree :).

What's the git repo of your branch?


Alex
