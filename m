From: robdclark@gmail.com (Rob Clark)
Date: Tue, 3 Feb 2015 11:22:01 -0500
Subject: [Linaro-mm-sig] [RFCv3 2/2] dma-buf: add helpers for sharing
 attacher constraints with dma-parms
In-Reply-To: <6906596.JU5vQoa1jV@wuerfel>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <3783167.LiVXgA35gN@wuerfel>
 <20150203155404.GV8656@n2100.arm.linux.org.uk>
 <6906596.JU5vQoa1jV@wuerfel>
Message-ID: <CAF6AEGsttiufoqPbDiZfUX2ndbv2XfeZzcfyaf-AcUJgJpgLkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 11:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I agree for the case you are describing here. From what I understood
> from Rob was that he is looking at something more like:
>
> Fig 3
> CPU--L1cache--L2cache--Memory--IOMMU---<iobus>--device
>
> where the IOMMU controls one or more contexts per device, and is
> shared across GPU and non-GPU devices. Here, we need to use the
> dmap-mapping interface to set up the IO page table for any device
> that is unable to address all of system RAM, and we can use it
> for purposes like isolation of the devices. There are also cases
> where using the IOMMU is not optional.


Actually, just to clarify, the IOMMU instance is specific to the GPU..
not shared with other devices.  Otherwise managing multiple contexts
would go quite badly..

But other devices have their own instance of the same IOMMU.. so same
driver could be used.

BR,
-R
