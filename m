From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Fri, 10 Dec 2010 12:47:02 -0600
Subject: [PATCH] OMAP: device: make rt_va easily avaialable to drivers
In-Reply-To: <87oc8uc1dg.fsf@deeprootsystems.com>
References: <1291852792-3584-1-git-send-email-omar.ramirez@ti.com>
	<87oc8uc1dg.fsf@deeprootsystems.com>
Message-ID: <AANLkTi=mGG5mRUP9VpH5AfPn1irNXn-+sZTFwjhG6_Jp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 9, 2010 at 11:16 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Omar Ramirez Luna <omar.ramirez@ti.com> writes:
>
>> Patch "OMAP: hwmod/device: add omap_{device, hwmod}_get_mpu_rt_va"[1],
>> introduces omap_device_get_rt_va which is meant to be called
>> by drivers to retrieve the _mpu_rt_va, however this function
>> receives a pointer to an omap_device; since there is no
>> practical way for a driver to get this parameter without
>> fiddling with pdev and container_of macro, and omap_device code
>> already does this, it is better for it to handle this case.
>>
>> Also moved header declaration to appear in the set of
>> functions to be used by drivers, as per the comment there.
>>
>> [1] http://marc.info/?l=linux-omap&m=127808467703366&w=2
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> Looks right, since all the other driver-accessible functions take a
> platform_device pointer, not an omap_device pointer.
>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> However, I thing the subject/shortlog should be clearer. ?IMO, this
> patch makes the API more consistent rather than making it easier.
> Also, subject prefix should be preferrably 'OMAP: omap_device:'.

I saw few patches following the convention "OMAP: device" that's why I
followed that one, I will change the subject/changelog according to
your suggestions.

Thanks,

Omar
