From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 14 Aug 2013 13:11:18 -0700
Subject: [PATCH 2/4] clk: exynos-audss: allow input clocks to be specified
 in device tree
In-Reply-To: <1610421.OFFn8rqlxt@amdc1227>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
 <1373458313-18970-3-git-send-email-padma.v@samsung.com>
 <1610421.OFFn8rqlxt@amdc1227>
Message-ID: <CAL1qeaFZH+3D26Vis4rUqCKK6Un-eHBv1wckYpPR-fac_gz6qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

> Well, this is basically how it should be done, but in current state of
> clock core I can see a problem: can we really rely on the order of clock
> initialization? I mean, we can't defer initialization of particular clock
> controller until all external clocks it needs are available, because there
> is no probing involved here.

Right, we can't.  The reason I added the device-tree lookup of input
clocks was because Exynos5420 has different names for several of the
input clocks to the audio block.  We already need a separate
compatibility string because of the ADMA clock, so we could just use
that to determine the parent clock names.  It's not ideal, but it's a
workaround for the initialization order issue.  Thoughts?

Thanks,
Andrew
