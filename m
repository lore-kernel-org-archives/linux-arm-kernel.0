From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 30 Apr 2014 00:52:17 +0200
Subject: [PATCH] PM / Sleep: Fall back to subsystem level PM callbacks for
 PM domains
In-Reply-To: <1753685.C73DLtyD2t@vostro.rjw.lan>
References: <1398422695-2295-1-git-send-email-ulf.hansson@linaro.org>
 <1753685.C73DLtyD2t@vostro.rjw.lan>
Message-ID: <1679843.u9z8cZFExt@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 30, 2014 12:47:28 AM Rafael J. Wysocki wrote:
> On Friday, April 25, 2014 12:44:55 PM Ulf Hansson wrote:
> > Previously once the PM core found a PM domain pointer for a device,
> > but which didn't have a valid PM callback, it falled back to try the
> > driver's PM callback.
> > 
> > In this scenario, change the behavior of the PM core to try out the
> > other subsystem level PM callbacks, before it moves on to the driver.
> > 
> > This gives provision for PM domains to easier re-use subsystem level
> > code to handle the needed operations.
> > 
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Are you sure this is not going to break the existing PM domains?

And even if it isn't, the idea behind PM domains was to provide a mechanism to
bypass the bus types' (etc) PM callbacks, so I'm not liking this patch at all.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
