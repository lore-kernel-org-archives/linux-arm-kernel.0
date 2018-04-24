From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Tue, 24 Apr 2018 19:57:06 +0800
Subject: [RFC 1/2] iommu/arm-smmu-v3: Remove bypass in
 arm_smmu_reset_device
In-Reply-To: <9e2f8646-482a-e721-d1b6-e674de48e276@arm.com>
References: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
 <1524483959-54940-2-git-send-email-xieyisheng1@huawei.com>
 <9e2f8646-482a-e721-d1b6-e674de48e276@arm.com>
Message-ID: <85c3b7d4-19c0-ea9c-b698-18e199b1da6d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Thanks for your comment!
On 2018/4/24 0:07, Robin Murphy wrote:
> On 23/04/18 12:45, Yisheng Xie wrote:
>> Add a bypass parameter in arm_smmu_device to keep whether smmu device
>> should pypass or not, so parameter bypass in arm_smmu_reset_device can
>> be removed.
> 
> Given that the GBPA configuration implied by the bypass argument here
> is only there to avoid initialising a full stream table when the firmware
> is terminally broken, I wonder if it would make sense to simply skip
> allocating a stream table at all in that case. Then we could just base
> the subsequent SMMUEN/GPBA decision on whether strtab_cfg.strtab is valid or not.
> 
Yes, it may save many memory, and should be care about not access strtab when attach
device or other similar scenario, anyway software can achieve this after move bypass
to struct arm_smmu_device.

Thanks
Yisheng
> Robin.
> 
