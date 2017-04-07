From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Apr 2017 12:26:31 +0200
Subject: [Patch v4 12/12] Documention: v4l: Documentation for HEVC CIDs
In-Reply-To: <1491559409.15698.1237.camel@smitha-fedora>
References: <1491459105-16641-1-git-send-email-smitha.t@samsung.com>
 <CGME20170406061027epcas5p2628e0a8e0fd76e2e267fad3ea1209f65@epcas5p2.samsung.com>
 <1491459105-16641-13-git-send-email-smitha.t@samsung.com>
 <f68d8bd2-a2b4-7253-0a48-6c3f509e66cd@samsung.com>
 <1491559409.15698.1237.camel@smitha-fedora>
Message-ID: <b26d966f-5acd-5d1e-0cb6-0232f84c2b31@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2017 12:03 PM, Smitha T Murthy wrote:
>>> +``V4L2_CID_MPEG_VIDEO_HEVC_LF``
>>> +    Indicates loop filtering. Control ID 0 indicates loop filtering
>>> +    is enabled and when set to 1 indicates no filter.
 >>
>> "Setting this control to 0 enables loop filtering, setting this control
>> to 1 disables loop filtering." ?
>>
>> Couldn't the meaning be inverted, so setting the control to 0 disables
>> the loop filtering?
>>
>>From register point of view, this control value needs be 0 to enable
> loop filtering.

OK, this is true for our specific hardware/firmware implementation.

In general, for this user space interface I would rather define that
boolean control so value 1 enables LF and value 0 disables LF.
The driver could simply negate the value when writing registers.

BTW we might need to specify type of the control here as Hans suggested
commenting on other control.

--
Regards,
Sylwester
