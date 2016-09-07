From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 7 Sep 2016 12:35:57 +0200
Subject: [PATCH V10 2/8] ACPI: Add new IORT functions to support MSI
 domain handling
In-Reply-To: <f469f024-b1c9-8616-c841-663e3e3d0731@semihalf.com>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
 <1473152938-17388-3-git-send-email-tn@semihalf.com>
 <alpine.DEB.2.20.1609061219230.5647@nanos>
 <f469f024-b1c9-8616-c841-663e3e3d0731@semihalf.com>
Message-ID: <4ef60b61-666c-2be0-1fad-81aa441360bd@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael,

There are two fixes for iort.c:
1. patch 1 - convert switch to if-else in iort_match_node_callback()
2. patch 2 - remove static local variable for iort_get_device_domain()

Do you want me to repost these patches to get your ACK, or you want new V11?

Thanks,
Tomasz

On 06.09.2016 12:27, Tomasz Nowicki wrote:
> On 06.09.2016 12:20, Thomas Gleixner wrote:
>> On Tue, 6 Sep 2016, Tomasz Nowicki wrote:
>>> +/**
>>> + * iort_get_device_domain() - Find MSI domain related to a device
>>> + * @dev: The device.
>>> + * @req_id: Requester ID for the device.
>>> + *
>>> + * Returns: the MSI domain for this device, NULL otherwise
>>> + */
>>> +struct irq_domain *iort_get_device_domain(struct device *dev, u32
>>> req_id)
>>> +{
>>> +    static struct fwnode_handle *handle;
>>
>> static ??????
>>
>>> +    int its_id;
>>> +
>>> +    if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
>>> +        return NULL;
>>> +
>>> +    handle = iort_find_domain_token(its_id);
>>
>> You reevaluate that on every call.
>>
>
> Obviously it is the bug. Thanks for spotting this.
>
> Tomasz
