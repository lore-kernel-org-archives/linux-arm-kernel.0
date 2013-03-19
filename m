From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 16:10:26 -0600
Subject: [PATCH V4 6/9] ARM: mxs: Provide regulator to pwm-backlight
In-Reply-To: <201303192227.21717.marex@denx.de>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-7-git-send-email-achew@nvidia.com>
 <201303192227.21717.marex@denx.de>
Message-ID: <5148E252.9050900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 03:27 PM, Marek Vasut wrote:
> Dear Andrew Chew,
> 
>> The pwm-backlight driver now takes a mandatory regulator that is gotten
>> during driver probe.  Initialize a dummy regulator to satisfy this
>> requirement.
>>
>> Signed-off-by: Andrew Chew <achew@nvidia.com>
> 
> Do we really need a mandatory regulator? Why can't it be optional?

IIRC, the previous advice I've seen is that if a device (driver) uses a
regulator, it must /require/ a regulator, and if a particular board
doesn't actually have a SW-controlled regulator, then a fixed- or dummy-
regulator should be provided to satisfy this requirement.

CC'ing Mark Brown to make sure I really do Recall Correctly.
