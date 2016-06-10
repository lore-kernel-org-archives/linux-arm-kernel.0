From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 10 Jun 2016 18:41:52 +0200
Subject: [PATCH v2 06/20] drm: i915: Rely on the default ->best_encoder()
 behavior where appropriate
In-Reply-To: <20160610152412.GL3363@phenom.ffwll.local>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465300095-16971-7-git-send-email-boris.brezillon@free-electrons.com>
 <20160610152412.GL3363@phenom.ffwll.local>
Message-ID: <20160610164152.GO3363@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 05:24:12PM +0200, Daniel Vetter wrote:
> On Tue, Jun 07, 2016 at 01:48:01PM +0200, Boris Brezillon wrote:
> > For all outputs except dp_mst, we have a 1:1 relationship between
> > connectors and encoders and the driver is relying on the atomic helpers:
> > we can drop the custom ->best_encoder() implementation and let the core
> > call drm_atomic_helper_best_encoder() for us.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> You can also drop the best_encoder from intel_dp_mst, we only need the
> atomic_best_encoder. The best_encoder there was needed to help out the
> fbdev emulation. Care to respin?

Boris pointed out on irc that this won't work for the fbdev stuff since
that has a WARN_ON if theres more than 1 possible encoder. Applied this
one here instead.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
