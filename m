From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 4 Feb 2013 10:55:27 +0530
Subject: [PATCH v3 13/15] ARM: CCI: ensure powerdown-time data is flushed
 from cache
In-Reply-To: <alpine.LFD.2.02.1302031327450.6300@xanadu.home>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-14-git-send-email-nicolas.pitre@linaro.org>
 <510B5CF7.5080902@ti.com> <alpine.LFD.2.02.1302021708460.6300@xanadu.home>
 <510E36CD.9000005@ti.com> <alpine.LFD.2.02.1302031327450.6300@xanadu.home>
Message-ID: <510F4647.6070505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 03 February 2013 11:59 PM, Nicolas Pitre wrote:
> On Sun, 3 Feb 2013, Santosh Shilimkar wrote:
>
>> On Sunday 03 February 2013 03:53 AM, Nicolas Pitre wrote:
>>> On Fri, 1 Feb 2013, Santosh Shilimkar wrote:
>>>
>>>> On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
>>>>> From: Dave Martin <dave.martin@linaro.org>

[..]

>>>>> This patch adds the appropriate flushing to the CCI driver to ensure
>>>>> that the relevant data is available in RAM ahead of time.
>>>>>
>>>>> Because this creates a dependency on arch-specific cacheflushing
>>>>> functions, this patch also makes ARM_CCI depend on ARM.
>>>>>
>>>> You should do that otherwise to avoid other arch building this
>>>> driver for random builds and breaking their builds.
>>>
>>> Before this patch the driver was buildable on any architecture.  That's
>>> why this dependency is added only in this patch.
>>>
>> I was just trying to counter the reasoning in the changelog which says
>> dependency is added because of arch specific cache flushing function.
>> Meaning even without that ARM dependency should be in place to avoid
>> driver getting build for other archs.
>
> Well, some upstream maintainers' opinion is that you should not put
> artificial dependencies on a specific architecture if a driver is
> buildable on any architecture, even if the built driver is of no use to
> those other architectures.
>
I see. I have seen some complaint about not adding the arch dependency.
Anyways, the patch has the dependency set with ARM and hence its
non-issue.

Regards,
Santosh
