From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 15 Oct 2015 10:16:12 +0300
Subject: [PATCH v5 00/24] dmaengine/ARM: Merge the edma drivers into one
In-Reply-To: <20151014143124.GU27370@localhost>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
 <20151014143124.GU27370@localhost>
Message-ID: <561F52BC.7040903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 05:31 PM, Vinod Koul wrote:
> On Wed, Oct 14, 2015 at 02:42:42PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> Cover letter:
>>
>> with this series the edma two driver setup will be changed to have only one
>> driver to support eDMA3. The legacy edma interface will be removed and eDMA can
>> only be used via dmaengine API from this point on.
>> In order to do the merge the following improvements has been done:
>> - One driver instance per eDMA:
>>  - Any number of eDMA instances are supported (both legacy and DT boot)
>> - Not relying on global variables, arrays, etc
>> - Code simplification and optimizations in several places
>>
>> This change will also help us to do bigger changes in the eDMA driver since,
>> since now we have only one driver to work with.
> 
> I have applied this now. I got a conlfict on 3rd one while applying and also
> I got conflict while merging to next
> 
> Pls verify all is well!

Thanks Vinod,

It looks fine.
It is strange since I'm working on top of linux-next as well. The following
commit caused the conflict:
ddfe4d0cce78 dmaengine: edma: remove redundant conditions

I have it in my linux-next, but for some reason it is missing from your
topic/edma, so the series applied with conflicts there and when merging on top
of linux-next there were again conflict.

Thank you,
P?ter
