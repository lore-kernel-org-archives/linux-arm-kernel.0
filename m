From: john.garry@huawei.com (John Garry)
Date: Thu, 24 Aug 2017 16:01:08 +0100
Subject: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
In-Reply-To: <20170824143536.GA8904@arm.com>
References: <20170809100715.870516-1-shameerali.kolothum.thodi@huawei.com>
 <20170809100715.870516-4-shameerali.kolothum.thodi@huawei.com>
 <20170810172723.GD9980@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8383CC287@FRAEML521-MBX.china.huawei.com>
 <c6b7c641-b839-1388-7982-366e796e6ba9@huawei.com>
 <20170823132430.GB634@arm.com>
 <77b6c97f-f2d2-fd14-e83e-345addc5ea71@huawei.com>
 <20170823164301.GC590@arm.com>
 <53b9795c-6222-9cf0-50dc-9dafbfb67a2c@huawei.com>
 <20170824143536.GA8904@arm.com>
Message-ID: <9a40f823-4323-21fd-343c-83c412a23bf1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2017 15:35, Will Deacon wrote:
>>>> > >>OK, seems reasonable.
>>>> > >>
>>>> > >>We would consider blacklisting the device, where/how to do is the question.
>>>> > >>
>>>> > >>So the errata is in the GICv3 ITS/PCI host controller, and we just use the
>>>> > >>in-between SMMU (driver) to provide the workaround. So my initial impression
>>>> > >>is that the PCI host controller would have to be blacklisted IFF behind an
>>>> > >>IOMMU for DT firmware in pcie-hisi.c or pci quirks framework. How does it
>>>> > >>sound?
>>> > >
>>> > >If that avoids us running into the erratum, then fine by me. I'd obviously
>>> > >prefer we work-around it since we know how to, but that's up to you.
>> >
>> > I'm surpsised that you may want more errata workaround code to maintain.
>> >
>> > Anyway we'll check both approaches and show you how they look and go from
>> > there.
> Don't get me wrong, I don't dream about adding errata workarounds to the
> code, but our job as an operating system is to abstract the hardware from
> the user, which means dealing with its quirks whether we like it or not.
>

Fine, it's ok.

For our next platform, hip08, we will provide no DT FW support, so this 
whole DT grey area should not be an issue.

And hopefully no errata also.

Much appreciated,
John

> Thanks,
>
> Will
