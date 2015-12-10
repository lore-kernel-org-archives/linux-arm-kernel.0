From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 10 Dec 2015 20:49:37 +0800
Subject: [PATCH] iommu/dma: Map scatterlists more parsimoniously
In-Reply-To: <1447307229.27650.5.camel@mhfsdcap03>
References: <104b4682056bc5b4aa0afadd39196c03fc06555d.1447249098.git.robin.murphy@arm.com>
 <1447307229.27650.5.camel@mhfsdcap03>
Message-ID: <CAGS+omBWFgpQQKV2=qL9G6qPbW_EL2bSjkLPq6KwQGAdHEDSHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 1:47 PM, Yong Wu <yong.wu@mediatek.com> wrote:
> On Wed, 2015-11-11 at 14:54 +0000, Robin Murphy wrote:
>> Whilst blindly assuming the worst case for segment boundaries and
>> aligning every segment individually is safe from the point of view
>> of respecting the device's parameters, it is also undeniably a waste
>> of IOVA space. Futhermore, the knock-on effects of more pages than

"Furthermore" (checkpatch actually caught this, not me ;-) )

>> necessary being exposed to device access, additional overhead in page
>> table updates and TLB invalidations, etc., are even more undesirable.
>>
>> Improve matters by taking the actual boundary mask into account to
>> actively detect the cases in which we really do need to adjust a
>> segment, and avoid wasting space in the remainder.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Hi all,
>>
>> I've given this some brief testing on Juno with USB and (via magic
>> PCI hacks) SATA to confirm that all the +1s and -1s at least seem to
>> be in the right places, so I'm throwing it out now for a head-start on
>> checking whether it also helps the media folks with the v4l portability
>> issues they're up against (I'm confident it should). If all goes well I
>> figure I'll repost next week based on rc1 instead of some random local
>> development commit.
>>
>> Robin.
>
> It works well on MT8173. containing
> VDA/VEA(VideoDecodeAccelerator/VideoEncodeAccelerator) unit test.
>
> Tested-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
