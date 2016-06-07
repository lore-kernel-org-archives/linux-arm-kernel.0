From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Jun 2016 17:42:18 +0100
Subject: HDLCD crashes with 6d910bfa809e
In-Reply-To: <20160607144058.GB3363@phenom.ffwll.local>
References: <5756B8A8.8000902@arm.com>
 <20160607144058.GB3363@phenom.ffwll.local>
Message-ID: <5756F96A.4010208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/16 15:40, Daniel Vetter wrote:
> On Tue, Jun 07, 2016 at 01:06:00PM +0100, Robin Murphy wrote:
>> Hi Daniel, Liviu,
>>
>> Having just inadvertently merged -next into my working branch, I find
>> dev6d910bfa809e ("drm/hlcd: Use lockless gem BO free callback") adversely
>> affecting my board's ability to boot ;)
>>
>> Since I (intentionally) don't have sufficient CMA to create a framebuffer,
>> drm_gem_cma_create() fails, unconditionally calls the now-NULL
>> drm->driver->gem_free_object() in its cleanup path, and fiery death
>> ensues...
>
> Please make sure you have the drm fixes from 4.7-rc2 included, this issue
> is fixed there.

Ah, right you are, thanks - the fact that that the newer branches I 
tried crashed or otherwise failed due to unrelated TDA998x problems 
threw me off. I see Chris' fix there now.

Robin.

> -Daniel
>
