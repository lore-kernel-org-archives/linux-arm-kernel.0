From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 18 Oct 2012 10:07:31 -0700
Subject: [RFC/NOT FOR MERGING 3/5] arm: omap: introduce other PM methods
In-Reply-To: <1350488043-5053-4-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Wed, 17 Oct 2012 18:34:01 +0300")
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-4-git-send-email-balbi@ti.com>
Message-ID: <878vb3g14c.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> current omap_device PM implementation defines
> omap-specific *_noirq methods but uses the
> generic versions for all other PM methods.
>
> As it turns out, if a device decides to implement
> non-runtime PM callbacks, we might fall into a
> situation where the hwmod is still idled which
> will generate an abort exception when we try
> to access device's address space while clocks
> are still gated.

Please explain in more detail how this could happen.

Kevin

> In order to solve that, we implement all other
> methods taking into account that devices might
> not implement those, in which case we return
> early.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
