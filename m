From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 12 Jun 2016 22:32:37 -0400
Subject: [PATCH V6 6/8] vfio, platform: make reset driver a requirement by
 default
In-Reply-To: <c3538f11-d206-1ffc-35e0-ff5a7672c7d9@redhat.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-7-git-send-email-okaya@codeaurora.org>
 <c3538f11-d206-1ffc-35e0-ff5a7672c7d9@redhat.com>
Message-ID: <575E1B45.3070406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/7/2016 3:59 PM, Auger Eric wrote:
>> -	vfio_platform_get_reset(vdev);
>> > +	ret = vfio_platform_get_reset(vdev);
>> > +	if (ret && vdev->reset_required) {
>> > +		pr_err("vfio: no reset function found for device %s\n",
>> > +		       vdev->name);
>> > +		iommu_group_put(group);
>> > +		return ret;
> nit: in case you respin you can factorize the group put and return ret in a goto label
> (since also used above).
> 
> Besides Reviewed-by: Eric Auger <eric.auger@redhat.com>

thanks, done. I'll respin with your request.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
