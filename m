From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 3 Jul 2015 23:37:09 +0900
Subject: [PATCH v2 3/5] drm/rockchip: vop: support plane scale
In-Reply-To: <5596626F.5050003@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-4-git-send-email-mark.yao@rock-chips.com>
 <CAAFQd5A2j7MXrzOMVnsJr_WUKAFPaicv+r9LgwHccLim4fRk8g@mail.gmail.com>
 <55965344.5050502@rock-chips.com>
 <CAAFQd5B3NnUQRqdaXUz6BGCn-5rh1iXnfZXnQRDK3=nF_Ya7SA@mail.gmail.com>
 <5596626F.5050003@rock-chips.com>
Message-ID: <CAAFQd5AM1-w8ynyn_Usr8OitdXSUcU85scvcYCTEZebzLqLn0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 3, 2015 at 7:22 PM, Mark yao <mark.yao@rock-chips.com> wrote:
> On 2015?07?03? 17:58, Tomasz Figa wrote:
>>>>
>>>> >>Aren't the scl_modes for CbCr planes always the same as for Y plane?
>>>
>>> >
>>> >
>>> >No, such as src(1920 x 1080) -> dst(1280x800), yuv format is NV12.
>>> >so Y plane horizontal and vertical is scale down.
>>> >
>>> >but src_w = 1920 / 2 = 960 < 1280
>>> >       src_h = 1080 / 2 = 540 < 800.
>>> >
>>> >So Cbcr horizontal and vertical is scale up.
>>
>> Sorry, I don't follow.
>>
>> If we scale down Y plane in NV12 from 1920x1080 to 1280x800, then
>> original CbCr plane will be 960x540 and destination CbCr plane will be
>> 640x400 (because CbCr plane of NV12 is subsampled 2x2, which is half
>> the width and half the height of Y plane), so both planes are being
>> scaled down.
>>
> destination CbCr plane is 1280x800, destination can't be subsample.

Ah, I see, so internally it's always scalling to destination plane
size. This means that calculation for both Y and CbCr must be done
indeed, but even then you could use helper functions for that, since
they differ only in parameters.

Best regards,
Tomasz
