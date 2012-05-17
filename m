From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 May 2012 15:23:53 -0600
Subject: [PATCH 7/7] MMC: mmci: Add required documentation for Device Tree
 bindings
In-Reply-To: <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20120517212353.0F9E53E0621@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Apr 2012 15:05:09 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> This provides full documentation detailing each compulsory,
> optional and device (variant) specific properties available
> for use within the MMCI Device Tree.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Should be merged with the mmc driver code changes.

g.

> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> new file mode 100644
> index 0000000..14a81d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -0,0 +1,19 @@
> +* ARM PrimeCell MultiMedia Card Interface (MMCI) PL180/1
> +
> +The ARM PrimeCell MMCI PL180 and PL181 provides and interface for
> +reading and writing to MultiMedia and SD cards alike.
> +
> +Required properties:
> +- compatible             : contains "arm,pl18x", "arm,primecell".
> +- reg                    : contains pl18x registers and length.
> +- interrupts             : contains the device IRQ(s).
> +- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
> +
> +Optional properties:
> +- wp-gpios               : contains any write protect (ro) gpios
> +- cd-gpios               : contains any card detection gpios
> +- cd-inverted            : indicates whether the cd gpio is inverted
> +- max-frequency          : contains the maximum operating frequency
> +- bus-width              : number of data lines, can be <1>, <4>, or <8>
> +- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
> +- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable
> -- 
> 1.7.9.1
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
