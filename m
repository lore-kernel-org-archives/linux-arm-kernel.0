From: padma.kvr@gmail.com (Padma Venkat)
Date: Thu, 14 Feb 2013 11:12:51 +0530
Subject: [PATCH V4 0/5] Add generic DMA DT binding support
In-Reply-To: <20130214044704.GE7777@intel.com>
References: <1360571905-15285-1-git-send-email-padma.v@samsung.com>
 <20130212144950.GJ3789@intel.com>
 <CAAgF-Be1w-8yjuyXT+d8sUO8dee1x7oYFJLXHCmcJSf17eXWyw@mail.gmail.com>
 <20130214044704.GE7777@intel.com>
Message-ID: <CAAgF-BfAE4Qt5KOBsn1iD7HW7_1e=TSEbuxNuTk0w8X+t3i-5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Thu, Feb 14, 2013 at 10:17 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Feb 13, 2013 at 09:52:30AM +0530, Padma Venkat wrote:
>> Hi Vinod,
>>
>> On Tue, Feb 12, 2013 at 8:19 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Mon, Feb 11, 2013 at 02:08:20PM +0530, Padmavathi Venna wrote:
>> >
>> > This looks fine, I have only question. The code seems to assume that pl330 dma
>> > controller always uses DT. But I dont see that as dependency for pl330.
> Have you checked this?

Sorry I didn't see this comment previously. I verified on SMDK6410
board which doesn't have DT support.
I didn't see any build error and it detected the sound card.

>
>> > Something tells me withot OF the driver may not build, have you checked it?
>> >
>> >> This patch set adds support for generic dma device tree bindings for
>> >> Samsung platforms and is dependent on the following patches from
>> >> Vinod Koul next branch
>> >> 1)of: Add generic device tree DMA helpers
>> >> 2)dmaengine: add helper function to request a slave DMA channel
>> >>
>> >> This patch set is made based Mark Brown next branch
>> > Is this targetted for ASoC tree, if so why? It would fail to build if applied
>> > there
>>
>> I have done this for my testing purpose (I expected all will directly
>> apply in your branch). But 3rd patch is not applied directly. I will
>> resend the patches after re-basing on your tree. 5th patch has to go
>> in ASoC tree because it has dependency on "ARM: SAMSUNG: Make dma
>> request compatible to generic dma bindings" which is there in ASoC
>> tree.
>>
>> Hi Mark,
>>
>> Can you please take the 5th patch in your tree(if there is no issue)
>> or should I resend it as a separate patch?
>>
>> >
>> > --
>> > ~Vinod
>> >>
>> >> Padmavathi Venna (5):
>> >>   DMA: PL330: Add new pl330 filter for DT case.
>> >>   DMA: PL330: Add xlate function
>> >>   DMA: PL330: Register the DMA controller with the generic DMA helpers
>> >>   ARM: dts: pl330: Add #dma-cells for generic dma binding support
>> >>   ARM: SAMSUNG: dma: Remove unnecessary code
>> >>
>> >>  .../devicetree/bindings/dma/arm-pl330.txt          |   21 +++++--
>> >>  arch/arm/boot/dts/exynos5250.dtsi                  |   12 ++++
>> >>  arch/arm/mach-s3c24xx/include/mach/dma.h           |    1 -
>> >>  arch/arm/mach-s3c64xx/include/mach/dma.h           |    1 -
>> >>  arch/arm/plat-samsung/dma-ops.c                    |   10 +---
>> >>  arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 -
>> >>  arch/arm/plat-samsung/include/plat/dma-pl330.h     |    1 -
>> >>  drivers/dma/pl330.c                                |   64 +++++++++++++++----
>> >>  8 files changed, 79 insertions(+), 32 deletions(-)
>> >>
>> >> --
>> >> 1.7.4.4
>> >>
>> Thanks
>> Padma
