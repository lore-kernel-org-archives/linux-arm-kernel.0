From: inki.dae@samsung.com (InKi Dae)
Date: Thu, 6 Sep 2012 16:21:31 +0900
Subject: [PATCH V4 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <CAH9JG2X_3iUTiGWv2cxjiX-s_VUtptVbzxhAJTub70W_2Dxecg@mail.gmail.com>
References: <1346859555-13527-1-git-send-email-l.krishna@samsung.com>
 <1346859555-13527-3-git-send-email-l.krishna@samsung.com>
 <CAH9JG2X_3iUTiGWv2cxjiX-s_VUtptVbzxhAJTub70W_2Dxecg@mail.gmail.com>
Message-ID: <CAAQKjZNmizjZ-=JN9_AysPMPHTOh7eydfE_OCYE6-v0JAJMydw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2012/9/5 Kyungmin Park <kmpark@infradead.org>:
> Hi,
>
> On Thu, Sep 6, 2012 at 12:39 AM, Leela Krishna Amudala
> <l.krishna@samsung.com> wrote:
>> Add device tree based discovery support for DRM-FIMD driver.
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/fb/drm-fimd.txt |   80 +++++++++++++++++
>>  drivers/gpu/drm/exynos/exynos_drm_fimd.c          |   95 ++++++++++++++++++++-
>>  2 files changed, 173 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/fb/drm-fimd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fb/drm-fimd.txt b/Documentation/devicetree/bindings/fb/drm-fimd.txt
>> new file mode 100644
>> index 0000000..4ff1829
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fb/drm-fimd.txt
>> @@ -0,0 +1,80 @@
>> +* Samsung Display Controller using DRM frame work
>> +
>> +The display controller is used to transfer image data from memory to an
>> +external LCD driver interface. It supports various color formats such as
>> +rgb and yuv.
>> +
>> +Required properties:
>> + - compatible: Should be "samsung,exynos5-fimd" or "samsung,exynos4-fb" for
> Doesn't better to use single word? fimd or fb?. I think 'fb' is used
> for framebuffer historically.
> but now it's used both fb and drm, so fimd is neutral and architecture
> specific.
>
> To do this, Modify arch-exynos first and update it at each drivers it properly.
>
> Thank you,
> Kyungmin Park
>

I agree with Kyungmin but I'd like to use as is. the reason we used
'exynos4-fb' as device name, is for that it uses fimd driver's
platform device commonly and gets fimd clock. so I think that dts file
should be defined with hardware specific name but not driver name such
as 'exynos4-fb'. but with this, we can't get fimd clock with device's
name because 'exynos4-fb' is used as device name of fimd clock. so to
use 'exynos4-fimd', we should modify the device name of fimd clock
from 'exynos4-fb'  to 'exynos4-fimd' and also ids definitions of
s3c-fb and drm fimd driver. so my conclusion is that it merges this
patch set as is and then let's modify related things later.
any opinions, welcome~ anytime.

Thanks.
Inki Dae
