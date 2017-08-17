From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Thu, 17 Aug 2017 17:43:50 +0300
Subject: [Patch v5 12/12] Documention: v4l: Documentation for HEVC CIDs
In-Reply-To: <1500290336.16819.6.camel@smitha-fedora>
References: <1497849055-26583-1-git-send-email-smitha.t@samsung.com>
 <CGME20170619052521epcas5p36a0bc384d10809dcfe775e6da87ed37b@epcas5p3.samsung.com>
 <1497849055-26583-13-git-send-email-smitha.t@samsung.com>
 <617cb1c5-074c-3f47-0096-fe7568dab8be@linaro.org>
 <1500290336.16819.6.camel@smitha-fedora>
Message-ID: <2ed312a5-513e-2ba4-6172-02cd151b3132@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/17/2017 02:18 PM, Smitha T Murthy wrote:
> On Fri, 2017-07-07 at 17:59 +0300, Stanimir Varbanov wrote:
>> Hi,
>>
>> On 06/19/2017 08:10 AM, Smitha T Murthy wrote:
>>> Added V4l2 controls for HEVC encoder
>>>
>>> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
>>> ---
>>>  Documentation/media/uapi/v4l/extended-controls.rst | 364 +++++++++++++++++++++
>>>  1 file changed, 364 insertions(+)
>>>

<cut>

>>
>>> +MFC 10.10 MPEG Controls
>>> +-----------------------
>>> +
>>> +The following MPEG class controls deal with MPEG decoding and encoding
>>> +settings that are specific to the Multi Format Codec 10.10 device present
>>> +in the S5P and Exynos family of SoCs by Samsung.
>>> +
>>> +
>>> +.. _mfc1010-control-id:
>>> +
>>> +MFC 10.10 Control IDs
>>> +^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +``V4L2_CID_MPEG_MFC10_VIDEO_HEVC_REF_NUMBER_FOR_PFRAMES (integer)``
>>> +    Selects number of P reference pictures required for HEVC encoder.
>>> +    P-Frame can use 1 or 2 frames for reference.
>>> +
>>> +``V4L2_CID_MPEG_MFC10_VIDEO_HEVC_PREPEND_SPSPPS_TO_IDR (integer)``
>>> +    Indicates whether to generate SPS and PPS at every IDR. Setting it to 0
>>> +    disables generating SPS and PPS at every IDR. Setting it to one enables
>>> +    generating SPS and PPS at every IDR.
>>> +
>>
>> I'm not sure those two should be driver specific, have to check does
>> venus driver has similar controls.
>>
> Yes please check and let me know if you have similar controls, I will
> move it out.
The venus encoder also has such a control so you can move it out of MFC
specific controls.

Also I think this control should be valid for every codec which supports
IDR, i.e. H264, so I think you could drop _HEVC_from the control name.

Do you plan to resend the patchset soon so that it could be applied for
4.14? If you haven't time let me know I can help with the generic HEVC
part of the patchset.

-- 
regards,
Stan
