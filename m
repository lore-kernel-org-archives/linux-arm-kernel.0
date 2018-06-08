From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Fri, 8 Jun 2018 15:56:03 +0300
Subject: [PATCH v2 1/2] media: v4l2-ctrl: Add control for VP9 profile
In-Reply-To: <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
References: <20180530071613.125768-1-keiichiw@chromium.org>
 <20180530071613.125768-2-keiichiw@chromium.org>
 <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
Message-ID: <bd56e330-91d2-dfde-4cfb-40b466953dad@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On 06/08/2018 12:29 PM, Hans Verkuil wrote:
> On 05/30/2018 09:16 AM, Keiichi Watanabe wrote:
>> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desired
>> profile for VP9 encoder and querying for supported profiles by VP9 encoder
>> or decoder.
>>
>> An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
>> used for querying since it is not a menu control but an integer
>> control, which cannot return an arbitrary set of supported profiles.
>>
>> The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
>> with controls for other codec profiles. (e.g. H264)
> 
> Please ignore my reply to patch 2/2. I looked at this a bit more and what you
> should do is to change the type of V4L2_CID_MPEG_VIDEO_VPX_PROFILE to enum.
> 
> All other codec profile controls are all enums, so the fact that VPX_PROFILE
> isn't is a bug. Changing the type should not cause any problems since the same
> control value is used when you set the control.
> 
> Sylwester: I see that s5p-mfc uses this control, but it is explicitly added
> as an integer type control, so the s5p-mfc driver should not be affected by
> changing the type of this control.
> 
> Stanimir: this will slightly change the venus driver, but since it is a very
> recent driver I think we can get away with changing the core type of the
> VPX_PROFILE control. I think that's better than ending up with two controls
> that do the same thing.

I agree. Actually the changes shouldn't be so much in venus driver.

-- 
regards,
Stan
