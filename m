From: kishon@ti.com (kishon)
Date: Thu, 21 Mar 2013 11:16:39 +0530
Subject: [PATCH v3 1/6] drivers: phy: add generic PHY framework
In-Reply-To: <514A39E3.6090501@gmail.com>
References: <1363770725-13717-1-git-send-email-kishon@ti.com>
 <1363770725-13717-2-git-send-email-kishon@ti.com>
 <514A39E3.6090501@gmail.com>
Message-ID: <514A9EBF.4030505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 21 March 2013 04:06 AM, Sylwester Nawrocki wrote:
> Hi Kishon,
>
> On 03/20/2013 10:12 AM, Kishon Vijay Abraham I wrote:
>> The PHY framework provides a set of APIs for the PHY drivers to
>> create/destroy a PHY and APIs for the PHY users to obtain a reference
>> to the
>> PHY with or without using phandle. To obtain a reference to the PHY
>> without
>> using phandle, the platform specfic intialization code (say from board
>> file)
>> should have already called phy_bind with the binding information. The
>> binding
>> information consists of phy's device name, phy user device name and an
>> index.
>> The index is used when the same phy user binds to mulitple phys.
>>
>> PHY drivers should create the PHY by passing phy_descriptor that has
>> describes the PHY (label, type etc..) and ops like init, exit,
>> suspend, resume,
>> poweron, shutdown.
>>
>> The documentation for the generic PHY framework is added in
>> Documentation/phy.txt and the documentation for the sysfs entry is added
>> in Documentation/ABI/testing/sysfs-class-phy.
>>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> ---
> [...]
>> +static inline struct phy *phy_get(struct device *dev, int index)
>> +{
>> +    return ERR_PTR(-EOPNOTSUPP);
>
> Shouldn't these be -ENOSYS ? EOPNOTSUPP is defined by POSIX as
> "Operation not supported on socket". And EOPNOTSUPP appears to be
> mostly used in the network code in the kernel.

Fair enough. Will change to ENOSYS.

Thanks
Kishon
