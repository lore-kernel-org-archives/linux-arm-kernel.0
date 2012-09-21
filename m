From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Sep 2012 10:06:10 -0600
Subject: [PATCH V6 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <CAAQKjZN7B1spgoD+LJjDU=PDd9jFk6g7PekuiKEeKpXLT-X4UA@mail.gmail.com>
References: <1348226536-22899-1-git-send-email-l.krishna@samsung.com>
 <1348226536-22899-3-git-send-email-l.krishna@samsung.com>
 <505BF79A.8060802@wwwdotorg.org>
 <CAAQKjZN7B1spgoD+LJjDU=PDd9jFk6g7PekuiKEeKpXLT-X4UA@mail.gmail.com>
Message-ID: <505C9072.2010204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2012 01:22 AM, Inki Dae wrote:
> 2012/9/21 Stephen Warren <swarren@wwwdotorg.org>:
>> On 09/21/2012 05:22 AM, Leela Krishna Amudala wrote:
>>> This patch adds device tree based discovery support for exynos DRM-FIMD
>>> driver which includes driver modification to handle platform data in
>>> both the cases with DT and non-DT, Also adds the documentation for bindings.
>>
>>> diff --git a/Documentation/devicetree/bindings/drm/exynos/fimd.txt b/Documentation/devicetree/bindings/drm/exynos/fimd.txt
>> ...
>>> + - samsung,fimd-display: This property should specify the phandle of the
>>> +   display device node which holds the video interface timing with the
>>> +   below mentioned properties.
>>> +
>>> +   - lcd-htiming: Specifies the horizontal timing for the overlay. The
>>> +     horizontal timing includes four parameters in the following order.
>>> +
>>> +     - horizontal back porch (in number of lcd clocks)
>>> +     - horizontal front porch (in number of lcd clocks)
>>> +     - hsync pulse width (in number of lcd clocks)
>>> +     - Display panels X resolution.
>>> +
>>> +   - lcd-vtiming: Specifies the vertical timing for the overlay. The
>>> +     vertical timing includes four parameters in the following order.
>>> +
>>> +     - vertical back porch (in number of lcd lines)
>>> +     - vertical front porch (in number of lcd lines)
>>> +     - vsync pulse width (in number of lcd clocks)
>>> +     - Display panels Y resolution.
>>
>> Should this not use the new videomode timings that are under discussion at:
>>
>> http://lists.freedesktop.org/archives/dri-devel/2012-July/024875.html
>>
> 
> ok, I agree with you. then the videomode helper is going to be merged
> to mainline(3.6)? if so, this patch should be reworked based on the
> videomode helper.

I think the videomode helpers would be merged for 3.7 at the very
earliest; 3.6 is cooked already. Given there are still some comments on
the binding, perhaps it won't happen until 3.8, but it'd be best to ask
on that thread so that people more directly involved with the status can
answer.
