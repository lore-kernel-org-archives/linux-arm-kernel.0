From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 13 Mar 2017 06:27:06 -0700
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5904 support
In-Reply-To: <20170311030426.GB6677@lunn.ch>
References: <1489178411-6559-1-git-send-email-tharvey@gateworks.com>
 <04584d61-f1e2-3722-1f13-ff133edc0c22@gmail.com>
 <CAJ+vNU1NcW=y_c-jJBnAaOozrzYJAekd9BEiMdd2=Bpx=Ng79Q@mail.gmail.com>
 <b105d1ea-7975-bd21-0aa0-762060ceb62a@gmail.com>
 <20170311030426.GB6677@lunn.ch>
Message-ID: <CAJ+vNU0JNQuQEmG_oCu86cbG_wisVFRETNtCO1bC2ytMM+N2Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 7:04 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Mar 10, 2017 at 05:20:11PM -0800, Florian Fainelli wrote:
>> On 03/10/2017 05:07 PM, Tim Harvey wrote:
>> > On Fri, Mar 10, 2017 at 12:43 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> >>
>> >>> +     dsa {
>> >>> +             compatible = "marvell,dsa";
>> >>> +             #address-cells = <2>;
>> >>> +             #size-cells = <0>;
>> >>> +
>> >>> +             dsa,ethernet = <&fec>;
>> >>> +             dsa,mii-bus = <&mdio>;
>> >>> +
>> >>
>> >> Please consider using the new binding for DSA switches, see:
>> >>
>> >> https://patchwork.kernel.org/patch/9493037/
>> >>
>> >
>> > Hi Florian,
>> >
>> > I tried the new binding first, but haven't gotten it to work yet. Let
>> > me make sure I understand what I should be doing.
>> >
>> > This is a MV88E6176 so I first need to add dt support for that to the
>> > mv88e6xxx driver (which supports the device, just not via dt):
>
> Hi Tim
>
> Nope. The 6176 is compatible with the 6085.
>
>> > Then I remove the old binding and add the new binding as such:
>> >
>> > &fec {
>> >         pinctrl-names = "default";
>> >         pinctrl-0 = <&pinctrl_enet>;
>> >         phy-mode = "rgmii-id";
>> >         status = "okay";
>>
>> You most likely need to declare a fixed PHY for the FEC to be setting up
>> the link, speed and duplex?
>
> Take a look at arch/arm/boot/dts/vf610-zii-dev* as an example. This
> uses a vf610, so is somewhat similar to the imx6. Same fec driver, but
> the mdio is more complex due to there being 3 switches.
>
>      Andrew

Andrew,

Thanks for the hint on the compatibility. I wonder if
Documentation/devicetree/bindings/net/dsa/marvell.txt should have some
notes added about switch device compatibility? It wasn't clear to me
that these would be compatible.

What is the convention, if any, of the naming of the 'lan' ports (0
based vs 1 based, eth vs lan)? Is it strictly up to the board vendor?
The board I'm supporting has a silkscreen that shows 'Port 1' through
'Port 4' so I was leaning towards 1 based.

Thanks,

Tim
