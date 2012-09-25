From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 25 Sep 2012 15:03:45 +0200
Subject: [PATCH V6 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <CAAQKjZMZBDpKinZkDUX7CU4yTXmu9GrP1+OiZJKW4Gx1BTno3Q@mail.gmail.com>
References: <1348226536-22899-1-git-send-email-l.krishna@samsung.com>
 <505C9072.2010204@wwwdotorg.org>
 <CAAQKjZMZBDpKinZkDUX7CU4yTXmu9GrP1+OiZJKW4Gx1BTno3Q@mail.gmail.com>
Message-ID: <2368486.hLKA5vLF0M@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 September 2012 21:35:46 Inki Dae wrote:
> 2012/9/22 Stephen Warren <swarren@wwwdotorg.org>:
> > On 09/21/2012 01:22 AM, Inki Dae wrote:
> >> 2012/9/21 Stephen Warren <swarren@wwwdotorg.org>:
> >>> On 09/21/2012 05:22 AM, Leela Krishna Amudala wrote:
> >>>> This patch adds device tree based discovery support for exynos DRM-FIMD
> >>>> driver which includes driver modification to handle platform data in
> >>>> both the cases with DT and non-DT, Also adds the documentation for
> >>>> bindings.
> >>>> 
> >>>> diff --git a/Documentation/devicetree/bindings/drm/exynos/fimd.txt
> >>>> b/Documentation/devicetree/bindings/drm/exynos/fimd.txt>>> 
> >>> ...
> >>> 
> >>>> + - samsung,fimd-display: This property should specify the phandle of
> >>>> the
> >>>> +   display device node which holds the video interface timing with the
> >>>> +   below mentioned properties.
> >>>> +
> >>>> +   - lcd-htiming: Specifies the horizontal timing for the overlay. The
> >>>> +     horizontal timing includes four parameters in the following
> >>>> order.
> >>>> +
> >>>> +     - horizontal back porch (in number of lcd clocks)
> >>>> +     - horizontal front porch (in number of lcd clocks)
> >>>> +     - hsync pulse width (in number of lcd clocks)
> >>>> +     - Display panels X resolution.
> >>>> +
> >>>> +   - lcd-vtiming: Specifies the vertical timing for the overlay. The
> >>>> +     vertical timing includes four parameters in the following order.
> >>>> +
> >>>> +     - vertical back porch (in number of lcd lines)
> >>>> +     - vertical front porch (in number of lcd lines)
> >>>> +     - vsync pulse width (in number of lcd clocks)
> >>>> +     - Display panels Y resolution.
> >>> 
> >>> Should this not use the new videomode timings that are under discussion
> >>> at:
> >>> 
> >>> http://lists.freedesktop.org/archives/dri-devel/2012-July/024875.html
> >> 
> >> ok, I agree with you. then the videomode helper is going to be merged
> >> to mainline(3.6)? if so, this patch should be reworked based on the
> >> videomode helper.
> > 
> > I think the videomode helpers would be merged for 3.7 at the very
> > earliest; 3.6 is cooked already. Given there are still some comments on
> > the binding, perhaps it won't happen until 3.8, but it'd be best to ask
> > on that thread so that people more directly involved with the status can
> > answer.
> 
> as I mentioned before, it's better to use videomode helper instead but
> for this, we should wait for that the videomode helper are merged to
> mainline so I think it's better to merge it as is and then modify it
> for videomode helper to be used later.

Aren't DT bindings considered as an ABI, and required to be supported more or 
less forever ? If you merge this DT binding you'll have to keep supporting it. 
That's why DT bindings should not be rushed in.

-- 
Regards,

Laurent Pinchart
