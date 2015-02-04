From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 4 Feb 2015 14:45:31 -0600
Subject: qcom firmware / scm interface (was Re: [GIT PULL] qcom SoC changes
 for v3.20)
In-Reply-To: <CAOesGMht4VaNgwr5rOyher081Vk7w_HKTMeOm677rEAkOcCPAg@mail.gmail.com>
References: <alpine.DEB.2.02.1501191226010.2973@galak-ubuntu.qualcomm.com>
 <20150122011521.GA31815@quad.lixom.net>
 <D177DF12-0F31-49CF-B98B-9FAC23AAB24C@codeaurora.org>
 <CAOesGMipp=Odc-cWvrba0e1pd1X7O+PKNH+WoM3fG4xX2GRFuA@mail.gmail.com>
 <DBE63F76-D4CB-49D5-90C6-642CFCA7687F@codeaurora.org>
 <CAOesGMht4VaNgwr5rOyher081Vk7w_HKTMeOm677rEAkOcCPAg@mail.gmail.com>
Message-ID: <9F29C4A8-BD35-4E87-9765-56597A38F134@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> I'd be OK with merging this, send a request and tag. Would that let
>>> the DRM folks make progress too?
>> 
>> Will do, I don?t think it will address the DRM folks needs as they need access to make firmware calls from the DRM driver.
>> 
>>> If you need a common place for this, drivers/firmware seems like a
>>> better home than drivers/soc.
>> 
>> Agreed, what?s you take than on moving to use firmware_ops as defined in arch/arm and extended it or just leaving this as a qcom specific firmware interface?
> 
> Are there any other SoCs out there with similar requirements on
> firmware interfaces? I think most of them so far have been fairly
> simple compared to the complexity of the qualcomm firmware.
> 
> Would it make sense to use firmware_ops for the common pieces and have
> direct smc calls for the rest? I'm not sure that would buy us all that
> much. Hm.
> 
> Well, at least it's an internal implementation detail. If we move it
> now and find a better way to do it down the road it can be refactored.

So I?ve been looking at the ARM firmware_ops and I?m not sure it makes much sense to try and contort either the QCOM SCM interface to match or the other way around.  The firmware_ops don?t really match what the qcom scm interface exposes and trying to make it would just seem to make the firmware_ops to QCOM specific to be of any value.

I?ll look at cleaning up the SCM code and moving it to drivers/firmware instead of drivers/soc/qcom if that is more desirable.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
