From: labbott@redhat.com (Laura Abbott)
Date: Fri, 3 Mar 2017 11:16:14 -0800
Subject: [RFC PATCH 00/12] Ion cleanup in preparation for moving out of
 staging
In-Reply-To: <10344634.XsotFaGzfj@avalon>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <20170303100433.lm5t4hqxj6friyp6@phenom.ffwll.local>
 <10344634.XsotFaGzfj@avalon>
Message-ID: <7acd4b8d-b2c2-2e08-8f9a-7d0c2146cc49@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 08:45 AM, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Friday 03 Mar 2017 11:04:33 Daniel Vetter wrote:
>> On Thu, Mar 02, 2017 at 01:44:32PM -0800, Laura Abbott wrote:
>>> Hi,
>>>
>>> There's been some recent discussions[1] about Ion-like frameworks. There's
>>> apparently interest in just keeping Ion since it works reasonablly well.
>>> This series does what should be the final clean ups for it to possibly be
>>> moved out of staging.
>>>
>>> This includes the following:
>>> - Some general clean up and removal of features that never got a lot of
>>>   use as far as I can tell.
>>>
>>> - Fixing up the caching. This is the series I proposed back in December[2]
>>>   but never heard any feedback on. It will certainly break existing
>>>   applications that rely on the implicit caching. I'd rather make an
>>>   effort to move to a model that isn't going directly against the
>>>   establishement though.
>>>
>>> - Fixing up the platform support. The devicetree approach was never well
>>>   recieved by DT maintainers. The proposal here is to think of Ion less as
>>>   specifying requirements and more of a framework for exposing memory to
>>>   userspace.
>>>
>>> - CMA allocations now happen without the need of a dummy device structure.
>>>   This fixes a bunch of the reasons why I attempted to add devicetree
>>>   support before.
>>>
>>> I've had problems getting feedback in the past so if I don't hear any
>>> major objections I'm going to send out with the RFC dropped to be picked
>>> up. The only reason there isn't a patch to come out of staging is to
>>> discuss any other changes to the ABI people might want. Once this comes
>>> out of staging, I really don't want to mess with the ABI.
>>>
>>> Feedback appreciated.
>>
>> Imo looks all good. And I just realized that cross-checking with the TODO,
>> the 2 items about _CUSTOM and _IMPORT ioctls I noted are already there.
>>
>> Otherwise I looked through the patches, looks all really reasonable.
> 
> Two more items that need to be addressed in my opinion :
> 
> - Let's not export the ion_client API, we don't want drivers to be ion-
> specific. Only the dma-buf interface should be visible to drivers.
> 

Yes, that's a good point. I never heard back from anyone about a need for
in kernel allocation via Ion.

Thanks,
Laura
