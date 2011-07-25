From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 25 Jul 2011 22:01:23 +0530
Subject: [PATCH v2 2/6] arm: davinci: Explicitly set channel
	controllers' default queues
In-Reply-To: <4E2D70B9.7060202@mvista.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-3-git-send-email-ido@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DD2CE05@dbde02.ent.ti.com>
	<4E2D70B9.7060202@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEA5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Jul 25, 2011 at 19:03:45, Sergei Shtylyov wrote:
> Hello.
> 
> Nori, Sekhar wrote:
> 
> >> Davinci platforms may define a default queue for each channel
> >> controller. If one is not defined, the default queue is set to EVENTQ_1.
> >> However, there's no way to distinguish between an unset default queue to
> >> one that is set to EVENTQ_0, as EVENTQ_0 = 0.
> 
> >> Explicitly specify the default queue for all channel controllers on all
> >> Davinci platforms to EVENTQ_1, and don't overwrite it in the EDMA probe
> >> function.
> 
> >> One exception is the DA850 board, for which EVENTQ_1 is not a valid
> >> option for its second channel controller. Use EVENTQ_0 instead for that
> >> channel controller.
> 
> >> Signed-off-by: Ido Yariv <ido@wizery.com>
> 
> > Looks good to me. Will queue for v3.2/fixes
> 
>     Why wait for 3.2? If this is considered a fix, it should be applied to 3.1, no?

3.2/fixes just indicates it will be queued as a fix/cleanup
for 3.2 so it will have higher priority for merge when compared
to a new feature.

This patch doesn't really fix any existing broken functionality.
It corrects event queue configuration for EDMA CC1 on DA850 for
which there are no current users in mainline.

So, not sending for v3.1.

Thanks,
Sekhar
