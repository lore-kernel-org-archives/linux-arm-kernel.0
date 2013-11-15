From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 13:35:09 +0100
Subject: [PATCH 1/3] Documentation: Add APM X-Gene SoC 6.0Gbps SATA PHY
 driver binding documentation
In-Reply-To: <1384457519-21335-2-git-send-email-lho@apm.com>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <1384457519-21335-2-git-send-email-lho@apm.com>
Message-ID: <201311151335.09577.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 November 2013, Loc Ho wrote:
> +- id                   : PHY ID (0 = first, 1 = second, 2 = third)
> +- #phy-cells           : Shall be 0

Hmm, it seems like this would make more sense if you have #phy-cells=<1>
and have the PHY ID in user node as the argument.

> +- CTLE0                        : PHY override parameters for channel 0 register REG1
> +                         field CTLE_EQ. First value for Gen1, second value
> +                         for Gen2, and third value for Gen3. Default is 0x2.
> +- CTLE1                        : PHY override parameters for channel 1 register REG1
> +                         field CTLE_EQ. First value for Gen1, second value
> +                         for Gen2, and third value for Gen3. Default is 0x2.
> +- PQ0                  : PHY override parameters for channel 0 register REG125
> +                         field PQ_REG. First value for Gen1, second value
> +                         for Gen2, and third value for Gen3. Default is 0xA.
> +- PQ1                  : PHY override parameters for channel 1 register REG125
> +                         field PQ_REG. First value for Gen1, second value
> +                         for Gen2, and third value for Gen3. Default is 0xA.

As mentioned before, I don't think putting register-level information into the binding
is the right approach here.

	Arnd
