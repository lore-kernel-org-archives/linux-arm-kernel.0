From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 16:42:29 -0300
Subject: [PATCH v6 24/30] drm/rockchip: Disable PSR on input events
In-Reply-To: <20180405095000.9756-25-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <20180405095000.9756-25-enric.balletbo@collabora.com>
Message-ID: <aec7e2d36b4599f77bc419b8fe7c415815529c2f.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-04-05 at 11:49 +0200, Enric Balletbo i Serra wrote:
> From: "Kristian H. Kristensen" <hoegsberg@google.com>
> 
> To improve PSR exit latency, we speculatively start exiting when we
> receive input events. Occasionally, this may lead to false positives,
> but most of the time we get a head start on coming out of PSR.
> Depending
> on how userspace takes to produce a new frame in response to the
> event,
> this can completely hide the exit latency. In case of Chrome OS, we
> typically get the input notifier 50ms or more before the dirty_fb
> triggered exit.
> 

Why is this rockchip-specific? It sounds more like something
we'd want to integrate generically for drivers to leverage.

Regards,
Eze
