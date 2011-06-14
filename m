From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Tue, 14 Jun 2011 15:01:22 -0600
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory	Allocator
	added
In-Reply-To: <201106142242.25157.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>	<20110614170158.GU2419@fooishbar.org>	<BANLkTi=cJisuP8=_YSg4h-nsjGj3zsM7sg@mail.gmail.com>
	<201106142242.25157.arnd@arndb.de>
Message-ID: <4DF7CC22.6050602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2011 02:42 PM, Arnd Bergmann wrote:
> On Tuesday 14 June 2011 20:58:25 Zach Pfeffer wrote:
>> I've seen this split bank allocation in Qualcomm and TI SoCs, with
>> Samsung, that makes 3 major SoC vendors (I would be surprised if
>> Nvidia didn't also need to do this) - so I think some configurable
>> method to control allocations is necessarily. The chips can't do
>> decode without it (and by can't do I mean 1080P and higher decode is
>> not functionally useful). Far from special, this would appear to be
>> the default.
>
> Thanks for the insight, that's a much better argument than 'something
> may need it'. Are those all chips without an IOMMU or do we also
> need to solve the IOMMU case with split bank allocation?

Yes. The IOMMU case with split bank allocation is key, especially for shared
buffers. Consider the case where video is using a certain bank for performance
purposes and that frame is shared with the GPU.

Jordan
