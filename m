From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 9 Sep 2017 17:41:40 +0200
Subject: [PATCH 0/8] drm/sun4i: Make both display pipeline work together
In-Reply-To: <20170908075016.18657-1-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
Message-ID: <20170909154140.wmuh46kxamumyspz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 08, 2017 at 03:50:08PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> Previously I added support for two display pipelines for the sun4i-drm
> driver. At the time we did not have support for downstream encoders to
> actually test the second pipeline, nor having both pipelines active at
> the same time.
> 
> With HDMI encoder support now merged and support for it on sun6i in
> progress, we are now able to test both pipelines being active at the
> same time, with LCD output from one and HDMI from the other. Testing
> has revealed some more issues, such as component probing order. Also,
> we found out that muxing between the display backend and TCON was
> possible, and required for the second pipeline to work as intended.
> Last, the number of CRTCs provided to drm_vblank_init needs to be
> increased for vblanks to work properly.
> 
> This patch series does a few things:
> 
>   - Fix endpoint IDs so they conform to what the DT binding stipulates.
> 
>   - Change the order the individual components are queued up.
> 
>   - Fix how the TCON gets its ID when the backend-TCON mux is present.
> 
>   - Support the input mux in the TCON (which selects which backend to
>     use on the A31/A31s).
> 
>   - Fix the drm_vblank_init call and pass the correct number of crtcs.
> 
>   - Add the cross pipeline connections between the DRCs and TCONs on
>     the A31, conforming to the DT binding and what the hardware is
>     capable of.
> 
> More details are available in each individual commit. Please have a look.

I've applied all the commits, with:
patch 1 in our arm-soc fixes branch
patch 2-7 in drm-misc-next
patch 8 in sunxi/dt-for-4.15.

I have a minor comment on one patch that can be fixed in a followup
patch, so please have a look at my other mail.

Thanks for this great work,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170909/2c2475c7/attachment.sig>
