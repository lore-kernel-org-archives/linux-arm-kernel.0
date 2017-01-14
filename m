From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 14 Jan 2017 11:00:29 +0800
Subject: [PATCH v7 12/15] msi: platform: make
 platform_msi_create_device_domain() ACPI aware
In-Reply-To: <20170113104524.GC20837@red-moon>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-13-git-send-email-hanjun.guo@linaro.org>
 <20170113104524.GC20837@red-moon>
Message-ID: <5879944D.9020005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/13 18:45, Lorenzo Pieralisi wrote:
> On Wed, Jan 11, 2017 at 11:06:36PM +0800, Hanjun Guo wrote:
>> platform_msi_create_device_domain() is used to ctreate
>> irqdomain for the device such as irqchip mbigen generating
>> the MSIs, it's almost ready for ACPI use except
>> of_node_to_fwnode() is for dt only, make it ACPI aware then
>> things will work in both DTS and ACPI.
> "The irqdomain creation carried out in:
>
> platform_msi_create_device_domain()
>
> relies on the fwnode_handle interrupt controller token to associate the
> interrupt controller with a specific irqdomain. Current code relies on
> the OF layer to retrieve a fwnode_handle for the device representing the
> interrupt controller from its device->of_node pointer.  This makes
> platform_msi_create_device_domain() DT specific whilst it really is not
> because after the merge of commit f94277af03ea ("of/platform: Initialise
> dev->fwnode appropriately") the fwnode_handle can easily be retrieved
> from the dev->fwnode pointer in a firmware agnostic way.
>
> Update platform_msi_create_device_domain() to retrieve the interrupt
> controller fwnode_handle from the dev->fwnode pointer so that it can
> be used seamlessly in ACPI and DT systems".

Much better, I will update the patch.

>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks
Hanjun
