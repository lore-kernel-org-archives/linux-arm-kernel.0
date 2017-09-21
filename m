From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 21 Sep 2017 16:06:49 +0530
Subject: [PATCH v2 0/4] phy: rockchip-typec: Set "flip" properly; some
 cleanups; fix swing
In-Reply-To: <20170919195630.18747-1-dianders@chromium.org>
References: <20170919195630.18747-1-dianders@chromium.org>
Message-ID: <9d892f99-d48d-b034-8f50-2719ef07d0b1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Douglas,

On Wednesday 20 September 2017 01:26 AM, Douglas Anderson wrote:
> When connecting to certain DP monitors it was observed that only one
> of the two orientations of the type C to DP cable would work.
> Debugging showed that the problem was that we needed to set the type C
> "flip" state earlier.  Once we did this, problems went away.
> 
> While trying to dig into this problem and some others, I found that
> the proper documentation for the Type C PHY was available to me.  This
> allowed me to cleanup the magic numbers in the funtion that I was
> touching and also fix a few minor issues that (luckily) haven't caused
> any problems yet.
> 
> I also found that aux channel communications were flaky on some
> adapters until I adjusted the voltage swing.

>From the commit log, looks like only the 1st and 4th patch are fixes. Only
those can go in -rc cycle. But I can't apply the 4th patch without the 2nd and
3rd patch.

Can you resend the series such that 2nd and 3rd patch apply on top of 1st and
4th patch?

Thanks
Kishon
