From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 08 Nov 2018 12:15:56 +1030
Subject: [PATCH v2 1/2] ARM: dts: Add Facebook BMC flash layout
In-Reply-To: <c5e56fc4-397f-a38b-6378-99eecce1180b@fb.com>
References: <20181106042829.2771226-1-taoren@fb.com>
 <1541635320.1462459.1569430616.0F5E4C4D@webmail.messagingengine.com>
 <c5e56fc4-397f-a38b-6378-99eecce1180b@fb.com>
Message-ID: <1541641556.1495362.1569509568.7BE039CA@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2018, at 10:48, Tao Ren wrote:
> On 11/7/18 4:02 PM, Andrew Jeffery wrote:
> >> +partitions {
> >> +	compatible = "fixed-partitions";
> >> +	#address-cells = <1>;
> >> +	#size-cells = <1>;
> >> +
> >> +	u-boot at 0 {
> >> +		reg = <0x0 0x60000>;
> >> +		label = "u-boot";
> >> +	};
> >> +
> >> +	u-boot-env at 60000 {
> >> +		reg = <0x60000 0x20000>;
> >> +		label = "env";
> >> +	};
> >> +
> >> +	fit at 80000 {
> >> +		reg = <0x80000 0x1b80000>;
> >> +		label = "fit";
> >> +	};
> >> +
> >> +	data0 at 1c00000 {
> >> +		reg = <0x1c00000 0x400000>;
> >> +		label = "data0";
> >> +	};
> >> +
> >> +	flash0 at 0 {
> >> +		reg = <0x0 0x2000000>;
> >> +		label = "flash0";
> >> +	};
> > 
> > Is this necessary? Isn't the same thing achieved with the /dev/mtd0 device?
> 
> Hi Andrew,
> 
> Thank you for the review! The new layout file is needed mainly because 
> of "data0" partition: several facebook platforms use the partition as 
> "persistent" storage.
> 
> As for "flash0", technically it's not needed (as you pointed out, /dev/
> mtd0 covers the entire flash if master_partition is enabled). It's still 
> here to avoid breaking some legacy applications.

This is what I expected. I think it might be worth adding a comment, given
you are respinning the series to address my comments on the board
devicetree patch.

Anyway, thanks for the clarification.

Andrew
