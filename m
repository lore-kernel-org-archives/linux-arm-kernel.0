From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Sep 2018 13:07:41 +0200
Subject: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
In-Reply-To: <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
 <4035252.QuWadVx7pr@avalon>
 <1569297.pdEFdpi3HS@avalon> <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
Message-ID: <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
> On 05.09.2018 00:44, Laurent Pinchart wrote:

> Good point! I actually really don't like that we use the same flags here
> but from a different perspective. Especially since the flags defines
> document things differently:
>
> /* drive data on pos. edge */
> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> /* drive data on neg. edge */
> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)

Maybe a stupid comment from my side, but can't we just change the
documentation to match the usecases?

/* Trigger pixel data latch on positive edge */
#define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)

> Using the opposite perspective would also need translation in crtc
> drivers... So far no driver uses sampling_edge.
>
> I would prefer if we always use the meaning as documented by the flags.
>
> I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
> DRM_BUS_FLAG_PIXDATA_NEGEDGE.
>
> Linus Walleij, you added sampling edge, any thoughts?

I just thought it was generally useful to have triggering edge encoded
into the bridge as it makes it clear that this edge is something
that is a delayed version of the driving edge which is subject to
clock skew caused by the speed of electrons in silicon and
copper and slew rate caused by parasitic capacitance.

Yours,
Linus Walleij
