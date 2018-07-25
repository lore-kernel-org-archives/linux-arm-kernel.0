From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 25 Jul 2018 23:38:06 +0800
Subject: [linux-sunxi] [PATCH v3 6/9] dt-bindings: phy: add binding for
 Allwinner USB3 PHY
In-Reply-To: <20180725153126.GA8350@rob-hp-laptop>
References: <20180722055739.26464-1-icenowy@aosc.io>
 <20180722055739.26464-7-icenowy@aosc.io>
 <CAGb2v65m6AEW=DO-cqLMyjfnaiZudm38hXufJL6LXdOrJqir_g@mail.gmail.com>
 <20180725153126.GA8350@rob-hp-laptop>
Message-ID: <75A6FEBC-FDCE-459E-93C5-60F4B0E6D44D@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?25? GMT+08:00 ??11:31:26, Rob Herring <robh@kernel.org> ??:
>On Sun, Jul 22, 2018 at 02:10:33PM +0800, Chen-Yu Tsai wrote:
>> On Sun, Jul 22, 2018 at 1:57 PM, Icenowy Zheng <icenowy@aosc.io>
>wrote:
>> > The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
>> > external USB3 pins of the SoC.
>> >
>> > Add a device tree binding for the PHY.
>> >
>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> > ---
>> > Changes in v3:
>> > - Added Chen-Yu's Review tag.
>> >
>> > Rob,
>> > Although you mentioned that the supply is for the port, not the
>phy;
>> > currently in USB situation "powering on the PHY" also indicates
>> > "powering on the port" and nearly all usages of phy-supply is for
>Vbus.
>> >
>> > Maybe we should change the overall phy-supply to satisfy this.
>> 
>> Or maybe change it to vbus-supply, like we have for phy-sun4i-usb,
>> until USB port power sequencing is added. (I remember there were
>> patches for this. What happened?)
>
>Once it is in the binding, we are stuck with it.
>
>Connector bindings have landed. We should add vbus-supply to that. You 
>don't have to have a property in the node associated with a driver. The

How should the phy DT node reference the connector?

>
>phy driver can walk the tree and get the Vbus supply.
>
>UniPhier has the same issue.
>
>Rob
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
