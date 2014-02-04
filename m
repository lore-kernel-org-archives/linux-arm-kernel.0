From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Feb 2014 08:22:32 -0800
Subject: [RFC/RFT 2/2] ARM: keystone: Install hooks for dma address
 translation routines
In-Reply-To: <201402041702.00039.arnd@arndb.de>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <CAOesGMgzsx3gE6cT-nMTJfnO1T5pvfTr8HA6tVGv8svF_kCYjg@mail.gmail.com>
 <52F0F979.2090505@ti.com> <201402041702.00039.arnd@arndb.de>
Message-ID: <CAOesGMg7tuyF-NhS93ji2vOdrg0B04Oeihnz0ctrQXc+9ZFdkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 8:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 04 February 2014, Santosh Shilimkar wrote:
>> > PPC servers use "ibm,dma-window" to describe the assigned dma address
>> > space for busses/devices, but the window itself doesn't contain any
>> > information about the physical address mapping (since it goes through
>> > an iommu after that). It likely doesn't fit this particular use case,
>> > but it's something we should look at as a base in case we need to
>> > start looking at bindings for this instead of coding it per SoC. We'll
>> > know more once we've seen what a few of the implementations out there
>> > are.
>> >
>> Understood.
>
> I think you are looking for the "dma-ranges" property, which describes
> how a device DMA address space maps into the parent bus address space
> for inbound translations. It's not used much in Linux, but it is clearly
> specified. The "ibm,dma-window" property OTOH is for the corner case
> that you have a small per-partition DMA address space section, which is
> not how things are done on most systems these days.

Ah, that might very well be the case. And it looks like dma-ranges
handles this case already. At least based on the first draft proposal
for dma-ranges that I came across. :)


-Olof
