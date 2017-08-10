From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Aug 2017 11:58:09 +0800
Subject: [PATCH v4 05/12] Documentation: net: phy: Add phy-is-internal
 binding
In-Reply-To: <20170810002041.GA10776@lunn.ch>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
 <1502280630-2254-1-git-send-email-david.wu@rock-chips.com>
 <778B0470-8ABD-46AD-A63D-F0CF4911C800@gmail.com>
 <20170810002041.GA10776@lunn.ch>
Message-ID: <CAGb2v65xMBKePss5R4j8P7fxcXkHOcYMNiWE=ApYG19v5un2tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 8:20 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Aug 09, 2017 at 03:47:34PM -0700, Florian Fainelli wrote:
>> On August 9, 2017 5:10:30 AM PDT, David Wu <david.wu@rock-chips.com> wrote:
>> >Add the documentation for internal phy. A boolean property
>> >indicates that a internal phy will be used.
>> >
>> >Signed-off-by: David Wu <david.wu@rock-chips.com>
>> >---
>> > Documentation/devicetree/bindings/net/phy.txt | 3 +++
>> > 1 file changed, 3 insertions(+)
>> >
>> >diff --git a/Documentation/devicetree/bindings/net/phy.txt
>> >b/Documentation/devicetree/bindings/net/phy.txt
>> >index b558576..942c892 100644
>> >--- a/Documentation/devicetree/bindings/net/phy.txt
>> >+++ b/Documentation/devicetree/bindings/net/phy.txt
>> >@@ -52,6 +52,9 @@ Optional Properties:
>> >   Mark the corresponding energy efficient ethernet mode as broken and
>> >   request the ethernet to stop advertising it.
>> >
>> >+- phy-is-internal: If set, indicates that phy will connect to the MAC
>> >as a
>> >+  internal phy.
>>
>> Something along the lines of:
>>
>> If set, indicates that the PHY is integrated into the same physical package as the Ethernet MAC.
>
> Hi Florian, David.
>
> I'm happy with the property name. But i think the text needs more
> description. We deal with Ethernet switches with integrated PHYs. Yet
> for us, this property is unneeded.
>
> Seeing this property means some bit of software needs to ensure the
> internal PHY should be used, when given the choice between an internal
> and external PHY. So i would say something like:
>
>     If set, indicates that the PHY is integrated into the same
>     physical package as the Ethernet MAC. If needed, muxers should be
>     configured to ensure the internal PHY is used. The absence of this
>     property indicates the muxers should be configured so that the
>     external PHY is used.
>
> This last part is important. If the bootloader has set the internal
> PHY to be used, you need to reset it. Otherwise we are going to get
> into a mess sometime later and need to add a phy-is-external property.

Ack.

One other thing. We need to fix our (sunxi) binding which is already
in 4.13-rc1. We'd like to see this new property in netdev, i.e. merged
for 4.13, so we can use it.

Thanks
ChenYu
