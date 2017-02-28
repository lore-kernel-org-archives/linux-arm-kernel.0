From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Feb 2017 12:32:45 +0000
Subject: [PATCH v3 11/25] ARM: dts: Add Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <20170228063535.32069-12-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-12-afaerber@suse.de>
Message-ID: <20170228123245.GF3691@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 28, 2017 at 07:35:21AM +0100, Andreas F?rber wrote:
> +/dts-v1/;
> +
> +#include "s500-guitar.dtsi"
> +
> +/ {
> +	compatible = "lemaker,guitar-bb-rev-b", "lemaker,guitar", "actions,s500";
> +	model = "LeMaker Guitar Base Board rev. B";
> +
> +	aliases {
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial3:115200n8";
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};

> +#include "s500.dtsi"
> +
> +/ {
> +	compatible = "lemaker,guitar", "actions,s500";
> +
> +	/delete-node/ memory;

Eww. Is this just bodging around skeleton.dtsi?

> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;
> +	};
> +};

> +#include "skeleton.dtsi"

Please don't include skeleton.dtsi. Please add the relevant nodes and
properties explciitly to your dts{i,} files.

> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {

Please define your #address-cells and #size-cells here.

If you want, add an empty /chosen node (not strictly necessary since
your dts file has a non-empty one anyhow).

Thanks,
Mark.
