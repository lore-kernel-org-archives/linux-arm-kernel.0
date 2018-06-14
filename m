From: keiichiw@chromium.org (Keiichi Watanabe)
Date: Thu, 14 Jun 2018 18:12:00 +0900
Subject: [PATCH v3 2/3] media: v4l2-ctrl: Add control for VP9 profile
In-Reply-To: <9cb304df-c600-918a-1c73-8daa9644f9c3@linaro.org>
References: <20180614074652.162796-1-keiichiw@chromium.org>
 <20180614074652.162796-3-keiichiw@chromium.org>
 <9cb304df-c600-918a-1c73-8daa9644f9c3@linaro.org>
Message-ID: <CAD90VcZT7M+egaBYXMdyGHUNq4wXmog9qFw3RjiPJ6cNszfkvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stanimir,

On Thu, Jun 14, 2018 at 5:06 PM, Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
> Hi Keiichi,
>
> On 06/14/2018 10:46 AM, Keiichi Watanabe wrote:
>> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for VP9
>> profiles. This control allows to select a desired profile for VP9
>> encoder and query for supported profiles by VP9 encoder/decoder.
>>
>> Though this control is similar to V4L2_CID_MPEG_VIDEO_VP8_PROFILE, we need to
>> separate this control from it because supported profiles usually differ between
>> VP8 and VP9.
>>
>> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>> ---
>>  .../media/uapi/v4l/extended-controls.rst      | 25 +++++++++++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls.c          | 11 ++++++++
>>  include/uapi/linux/v4l2-controls.h            |  7 ++++++
>>  3 files changed, 43 insertions(+)
>>
>> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
>> index de99eafb0872..095b42e9d6fe 100644
>> --- a/Documentation/media/uapi/v4l/extended-controls.rst
>> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
>> @@ -1980,6 +1980,31 @@ enum v4l2_mpeg_video_vp8_profile -
>>      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
>>        - Profile 3
>>
>> +.. _v4l2-mpeg-video-vp9-profile:
>> +
>> +``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
>> +    (enum)
>> +
>> +enum v4l2_mpeg_video_vp9_profile -
>

> what about vp9 levels, shouldn't we add them too? Or we will add it when
> there is a user.
>
It sounds good, but I don't think we should include them in this
series of patches now.
As you said, we can add them when someone wants to use them.

Best regards,
Keiichi

>
> --
> regards,
> Stan
