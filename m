From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Jul 2014 12:02:17 +0530
Subject: [PATCH 0/3] ARM/dma: edma: Serve cyclic clients via high priority
 queue
In-Reply-To: <53D5E9CF.10706@ti.com>
References: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
 <53D5E9CF.10706@ti.com>
Message-ID: <53D5EE71.3040707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 11:42 AM, Peter Ujfalusi wrote:
> On 07/08/2014 01:46 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> It is preferred that audio is served with the highest priority queue in order to
>> avoid delays in data transfer between memory and audio IP.
>>
>> The following series will add an API to arch code to assign a channel to a given
>> queue.
>> The default queue is changed from 0 (highest priority) to lowest priority.

This should not really change any performance behavior as everything at
highest priority is same as everything at lowest priority.

>> In the dmaengine driver we move the cyclic channel to queue0 (highest priority)
>> and move it back to default queue when the channel is terminated.
> 
> ping?

For 1/3 and 2/3:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Vinod, can you take the series together with your tree (if you are happy
with the series, that is)? I don't have anything else queued for this
merge window.

Thanks,
Sekhar
