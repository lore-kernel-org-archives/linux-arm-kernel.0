From: robh@kernel.org (Rob Herring)
Date: Mon, 28 Aug 2017 16:32:55 -0500
Subject: [PATCH v4 3/4] dt-bindings: PCI: rockchip: Add support for pcie
 wake irq
In-Reply-To: <20170825181959.GA64040@google.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
 <20170822031934.8675-4-jeffy.chen@rock-chips.com>
 <20170825181439.d3hlwrcbmcss3sx6@rob-hp-laptop>
 <20170825181959.GA64040@google.com>
Message-ID: <CAL_Jsq+MeiwOf=VDLZrxgPuLNEDvtGY=X-K1=6w9aaFVZgg1hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 1:20 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Fri, Aug 25, 2017 at 01:14:39PM -0500, Rob Herring wrote:
>> On Tue, Aug 22, 2017 at 11:19:33AM +0800, Jeffy Chen wrote:
>> > Add an optional interrupt for PCIE_WAKE pin.
>> >
>> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> > ---
>> >
>> > Changes in v4: None
>> > Changes in v3: None
>> > Changes in v2: None
>> >
>> >  .../devicetree/bindings/pci/rockchip-pcie.txt        | 20 ++++++++++++--------
>> >  1 file changed, 12 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> > index 5678be82530d..9f6504129e80 100644
>> > --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> > +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> > @@ -20,10 +20,13 @@ Required properties:
>> >  - msi-map: Maps a Requester ID to an MSI controller and associated
>> >     msi-specifier data. See ./pci-msi.txt
>> >  - interrupts: Three interrupt entries must be specified.
>> > -- interrupt-names: Must include the following names
>> > -   - "sys"
>> > -   - "legacy"
>> > -   - "client"
>> > +- interrupt-names: Include the following names
>> > +   Required:
>> > +           - "sys"
>> > +           - "legacy"
>> > +           - "client"
>> > +   Optional:
>> > +           - "wake"
>>
>> Use the wakeup source binding:
>> Documentation/devicetree/bindings/power/wakeup-source.txt
>
> And I suppose this means we'd fall under this paragraph?
>
>     "However if the devices have dedicated interrupt as the wakeup source
>     then they need to specify/identify the same using device specific
>     interrupt name. In such cases only that interrupt can be used as wakeup
>     interrupt."
>
> We don't expect *any* interrupt to qualify as PCI WAKE#; so we should
> still also document the interrupt name ("wake"?) in
> Documentation/devicetree/bindings/pci/pci.txt as Bjorn suggested, in
> addition to using the 'wakeup-source' property documented there.

I believe the defined interrupt name is "wakeup" as example 1 shows.

Rob
