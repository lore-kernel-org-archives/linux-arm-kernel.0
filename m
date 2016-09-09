From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 9 Sep 2016 14:54:07 +0100
Subject: [PATCH 08/10] PM / Domains: Add support for removing PM domains
In-Reply-To: <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-9-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
Message-ID: <c8498eca-6934-1cab-31d9-3d8ce4c74897@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/09/16 12:49, Ulf Hansson wrote:
> On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
>> The genpd framework allows users to add PM domains via the pm_genpd_init()
>> function, however, there is no corresponding function to remove a PM
>> domain. For most devices this may be fine as the PM domains are never
>> removed, however, for devices that wish to populate the PM domains from
>> within a driver, having the ability to remove a PM domain if the probing
>> of the device fails or the driver is unloaded is necessary.
>>
>> Add the function pm_genpd_remove() to remove a PM domain by referencing
>> it's generic_pm_domain structure.
>>
>> PM domains can only be removed if they are not a parent domain to
>> another PM domain and have no devices associated with them.
> 
> I think we should also check if the there's is a provider registered
> for the genpd, as it should also prevent the genpd from being removed.
> Right?

Yes I would agree. I had thought that after patch #4 of this series that
only the provider itself would be able to call this. However, we should
probably still verify that the provider has correctly remove itself.

> I noticed that you are adding the ->provider pointer to the genpd
> struct in patch 9/10. Perhaps re-structure $subject patch and 9/10 a
> bit to deal with this, so we can add the pm_genpd_remove() API in a
> more safe manner.

Yes I can add the >provider member before this patch.

Cheers
Jon

-- 
nvpublic
