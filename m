From: robherring2@gmail.com (Rob Herring)
Date: Thu, 8 Aug 2013 08:09:49 -0500
Subject: [PATCH v8 06/12] ARM: dts: Add description of System MMU of
 Exynos SoCs
In-Reply-To: <003801ce8eb7$d7647f10$862d7d30$@samsung.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <CAL_JsqJdh5F0rK3koAW7DvRVU3RwS5pLgR5sV_Bak+K-6CrRFA@mail.gmail.com>
 <003801ce8eb7$d7647f10$862d7d30$@samsung.com>
Message-ID: <CAL_Jsq+_5GekzXpjWrtKZi2jWuxHSJxkPmVC4zmakfjAYai=eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 8:05 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
>> -----Original Message-----
>> From: Rob Herring [mailto:robherring2 at gmail.com]
>> Sent: Saturday, July 27, 2013 10:55 PM
>> On Fri, Jul 26, 2013 at 6:28 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
>> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
>> > ---
>> >  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
>> >  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
>> >  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
>> >  arch/arm/boot/dts/exynos4x12.dtsi                  |   76 +++++
>> >  arch/arm/boot/dts/exynos5250.dtsi                  |  291 ++++++++++++++++++++
>> >  5 files changed, 617 insertions(+), 0 deletions(-)
>> >  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
>> > b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
>> > new file mode 100644
>> > index 0000000..92f0a33
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
>> > @@ -0,0 +1,103 @@
>> > +Samsung Exynos4210 IOMMU H/W, System MMU (System Memory Management Unit)
>> > +
>> > +Samsung's Exynos architecture contains System MMU that enables scattered
>> > +physical memory chunks visible as a contiguous region to DMA-capable peripheral
>> > +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
>> > +
>> > +System MMU is a sort of IOMMU and support identical translation table format to
>> > +ARMv7 translation tables with minimum set of page properties including access
>> > +permissions, shareability and security protection. In addition, System MMU has
>> > +another capabilities like L2 TLB or block-fetch buffers to minimize translation
>> > +latency.
>> > +
>> > +A System MMU is dedicated to a single master peripheral device.  Thus, it is
>> > +important to specify the correct System MMU in the device node of its master
>> > +device. Whereas a System MMU is dedicated to a master device, the master device
>> > +may have more than one System MMU.
>>
>> I don't follow the last sentence. Can you elaborate on the type of
>> connection you are talking about.
>>
> Grant also addressed that.
> He corrected the sentence like the following:
>
>   " Can I suggest rewriting the last two sentences to:
>      The master device node must correctly specify at least one
>      SystemMMU. A master  device may have more than one System MMU. "
>
> I will change the sentence
>
>> Also, please align with the ARM system MMU binding that Will Deacon
>> has submitted particularly in terms of how master connections are
>> described.
>>
> I didn't check it.
>
> Should this align with ARM System MMU bindings?
> System MMU in Exynos SoC is different from ARM System MMU.
> It does not follows the specifications of ARM System MMU.

I'm not saying the h/w is the same or even the same spec, but how you
describe a master to iommu connection needs to be done in the same
way. This should be done in the same way for ALL iommu's. And if what
is defined does not work for you, then we need to understand that and
fix the binding now.

Rob
