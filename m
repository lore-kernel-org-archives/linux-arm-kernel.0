From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 21 Sep 2016 11:38:55 -0700
Subject: [PATCH v2 2/6] Documentation: dt-bindings: Add documentation for
 the Meson USB2 PHYs
In-Reply-To: <20160920142944.GA16016@rob-hp-laptop> (Rob Herring's message of
 "Tue, 20 Sep 2016 09:29:45 -0500")
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-3-martin.blumenstingl@googlemail.com>
 <20160920142944.GA16016@rob-hp-laptop>
Message-ID: <7ha8f1hzcw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Sun, Sep 11, 2016 at 03:41:07PM +0200, Martin Blumenstingl wrote:
>> Add the documentation for the bindings for the Meson8b and GXBB USB2
>> PHYs.
>> 
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  .../devicetree/bindings/phy/meson-usb2-phy.txt     | 27 ++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
>> new file mode 100644
>> index 0000000..9da5ea2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
>> @@ -0,0 +1,27 @@
>> +* Amlogic USB2 PHY
>> +
>> +Required properties:
>> +- compatible:	Depending on the platform this should be one of:
>> +	"amlogic,meson8b-usb2-phy"
>> +	"amlogic,meson-gxbb-usb2-phy"
>> +- reg:		The base address and length of the registers
>> +- #phys-cells:	should be 0 (see phy-bindings.txt in this directory)
>> +- clocks:	phandle and clock identifier for the phy clocks
>> +- clock-names:	"usb_general" and "usb"
>> +
>> +Optional properties:
>> +- resets:	reference to the reset controller
>> +- phy-supply:	see phy-bindings.txt in this directory
>> +
>> +
>> +Example:
>> +
>> +usb0_phy: usb_phy at 0 {
>
> usb-phy at 0
>
> With that,
>
> Acked-by: Rob Herring <robh@kernel.org>
>

Oops, I had already merged this one.

Martin, can you send a fixup patch for the underscores?

Thanks,

Kevin
