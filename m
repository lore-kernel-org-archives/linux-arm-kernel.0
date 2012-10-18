From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 18 Oct 2012 11:19:35 +0530
Subject: [PATCH] ARM: OMAP2+: Only write the sysconfig on idle when
 necessary
In-Reply-To: <507F16F5.9020803@ti.com>
References: <1350504742-19995-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1210172023130.9767@utopia.booyaka.com>
 <507F16F5.9020803@ti.com>
Message-ID: <507F986F.90107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 October 2012 02:07 AM, Jon Hunter wrote:
> Ok, thanks. Yes, only updating the register when the cache value changed
> would not work due to the possibility of context being lost. So
> Rajendra's change makes sense. However, I think there is room to
> optimise this.
>
> With this change, on idle, the cache value and register value are only
> updated when needed. This should be safe.
>
> Are you looking to go one step further and only update the sysconfig on
> enabling when the context has been lost? That would require more
> changes. This was a quick optimisation I saw when reviewing the code.
>
> Rajendra, let me know if you have any comments.

Makes sense to me. To handle the more generic case of avoiding all
reads and writes whenever possible, and making the cache really behave
like a cache, as Paul suggested, is certainly more work and more
importantly more testing, as it would rely heavily on the context lost 
counters to work correctly. I feel there is still some work needed
around those counters to make them more robust before we start heading
in that direction.
