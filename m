From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Oct 2017 21:06:20 -0500
Subject: [RFCv2 PATCH 12/36] dt-bindings: document stall and PASID
 properties for IOMMU masters
In-Reply-To: <e7288f51-1cfa-44ce-e3ce-e9f3daf91579@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-13-jean-philippe.brucker@arm.com>
 <20171013191051.lgxbcobkzzj5guhv@rob-hp-laptop>
 <e7288f51-1cfa-44ce-e3ce-e9f3daf91579@arm.com>
Message-ID: <CAL_JsqLFDeNq=PoipFv4qjKKP2mhE+2Eou4dBZhfm=XuXxjHrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 5:23 AM, Jean-Philippe Brucker
<jean-philippe.brucker@arm.com> wrote:
> On 13/10/17 20:10, Rob Herring wrote:
>> On Fri, Oct 06, 2017 at 02:31:39PM +0100, Jean-Philippe Brucker wrote:
>>> On ARM systems, some platform devices behind an IOMMU may support stall
>>> and PASID features. Stall is the ability to recover from page faults and
>>> PASID offers multiple process address spaces to the device. Together they
>>> allow to do paging with a device. Let the firmware tell us when a device
>>> supports stall and PASID.
>>
>> Can't these be implied by the compatible string of the devices?
>
> I think that PASID capacity can be deduced from the compatible string but
> don't know how these devices will be implemented (the only known example
> being a software model for testing). In any case implementing PASID based
> on the compatible string is tricky, because the IOMMU driver needs to know
> PASID capacity before the device driver has had time to probe the device.
> Maybe we could get away with a static table associating compatible string
> to PASID capacity, but it's not very nice.
>
> For stall it's a property of the integration between device and IOMMU,
> much like the "iommus" property, so it can't be deduced only from the
> compatible string. It's crucial that the firmware validates that stalling
> is safe, because we don't have any other way to discover it.

Okay, fair enough. I'll let others comment.

Rob
