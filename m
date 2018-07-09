From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jul 2018 12:43:04 +0100
Subject: [PATCH v2] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
In-Reply-To: <20180706200051.1115-1-neeraj.dantu@octavosystems.com>
References: <20180706200051.1115-1-neeraj.dantu@octavosystems.com>
Message-ID: <20180709114304.GE6920@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 08:00:51PM +0000, Neeraj Dantu wrote:
> +&lcdc {
> +	status = "okay";
> +
> +	/* If you want to get 24 bit RGB and 16 BGR mode instead of
> +	 * current 16 bit RGB and 24 BGR modes, set the propety
> +	 * below to "crossed" and uncomment the video-ports -property
> +	 * in tda19988 node.
> +	 */
> +	blue-and-red-wiring = "straight";
...
> +&i2c0 {
> +	tda19988: tda19988 {

This should not be "tda19988" as the node name - DT requires generic
names, like "hdmi-encoder".

...
> +		/* Convert 24bit BGR to RGB, e.g. cross red and blue wiring */
> +		/* video-ports = <0x234501>; */

Please explain more what's going on here.

Can you set 24-bit RGB mode with the above configuration - presumably
the colours will come out wrong?

Exactly what is the wiring between the lcdc and tda998x?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
