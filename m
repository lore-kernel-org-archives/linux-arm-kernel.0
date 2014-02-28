From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Feb 2014 18:15:05 +0200
Subject: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI
 Connector
In-Reply-To: <20140228160612.GR21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>
 <20140228160612.GR21483@n2100.arm.linux.org.uk>
Message-ID: <5310B609.1010105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 18:06, Russell King - ARM Linux wrote:

>> +hdmi0: connector at 1 {
>> +	compatible = "hdmi-connector";
>> +	label = "hdmi";
>> +
>> +	hdmi_connector_in: endpoint {
>> +		remote-endpoint = <&tpd12s015_out>;
>> +	};
>> +};
> 
> It seems rather weird to have DVI connectors having an optional I2C
> property, but HDMI (which augments DVI) not having that as at least an
> optional property.

I have added only the properties that I have used. I did think about the
i2c for HDMI also, but thought that I don't use it, and so can't test
it, and so I could well create a bad binding.

And, as I don't see any issue in adding it later, when someone uses it,
I decided to leave it out.

> I can quite well see the iMX HDMI support needing an i2c bus here.
> 
> Also, HDMI has two connector standards - type A and type B, much like
> the single vs dual link of DVI.  Again, DRM exposes this to userspace.

True, but isn't that just a form factor? No functional differences? But
I agree, we can add the two types here also to the compatible string.

 Tomi



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/28e9e5c9/attachment.sig>
