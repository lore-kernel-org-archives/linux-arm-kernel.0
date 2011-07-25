From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 25 Jul 2011 17:33:45 +0400
Subject: [PATCH v2 2/6] arm: davinci: Explicitly set channel controllers'
	default queues
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CE05@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>	<1310303679-17936-3-git-send-email-ido@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DD2CE05@dbde02.ent.ti.com>
Message-ID: <4E2D70B9.7060202@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Nori, Sekhar wrote:

>> Davinci platforms may define a default queue for each channel
>> controller. If one is not defined, the default queue is set to EVENTQ_1.
>> However, there's no way to distinguish between an unset default queue to
>> one that is set to EVENTQ_0, as EVENTQ_0 = 0.

>> Explicitly specify the default queue for all channel controllers on all
>> Davinci platforms to EVENTQ_1, and don't overwrite it in the EDMA probe
>> function.

>> One exception is the DA850 board, for which EVENTQ_1 is not a valid
>> option for its second channel controller. Use EVENTQ_0 instead for that
>> channel controller.

>> Signed-off-by: Ido Yariv <ido@wizery.com>

> Looks good to me. Will queue for v3.2/fixes

    Why wait for 3.2? If this is considered a fix, it should be applied to 3.1, no?

WBR, Sergei
