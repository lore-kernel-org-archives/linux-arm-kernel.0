From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 5 Mar 2014 10:41:03 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <20140228162327.GT21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk> <5310B567.7040605@ti.com>
 <20140228162327.GT21483@n2100.arm.linux.org.uk>
Message-ID: <5316E31F.9050308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 18:23, Russell King - ARM Linux wrote:

> That's rather a lot of compatible strings.  Another possibility is:
> 
> 	compatible = "dvi-connector";
> 	analog;
> 	digital;
> 	single-link;
> 	dual-link;

I made the following changes compared to the posted version. I decided
to leave the "single-link" out, as it's implied if "digital" is set.

 Tomi

@@ -6,11 +6,16 @@ Required properties:

 Optional properties:
 - label: a symbolic name for the connector
-- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+- analog: the connector has DVI analog pins
+- digital: the connector has DVI digital pins
+- dual-link: the connector has pins for DVI dual-link

 Required nodes:
 - Video port for DVI input

+Note: One (or both) of 'analog' or 'digital' must be set.
+
 Example
 -------

@@ -18,7 +23,9 @@ dvi0: connector at 0 {
        compatible = "dvi-connector";
        label = "dvi";

-       i2c-bus = <&i2c3>;
+       digital;
+
+       ddc-i2c-bus = <&i2c3>;

        dvi_connector_in: endpoint {
                remote-endpoint = <&tfp410_out>;


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/4868fdb2/attachment.sig>
