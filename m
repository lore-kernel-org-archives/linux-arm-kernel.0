From: martin@lucina.net (Martin Lucina)
Date: Fri, 6 Jul 2018 17:04:01 +0200
Subject: [PATCH 05/10] arm64: dts: allwinner: a64: Olinuxino: enable USB
In-Reply-To: <20180706085210.17952-6-andre.przywara@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-6-andre.przywara@arm.com>
Message-ID: <20180706150401.mhqse677vdqtxdzy@nodbug.lucina.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, 06.07.2018 at?09:52, Andre Przywara wrote:
> The Olinuxino has two USB socket:
> USB0 is connected to a micro B socket. As it has the ID pin wired, we
> describe it as a proper OTG socket, which switches between host and
> device automatically.
> USB1 is connected to a normal USB A socket. PG9 enables the power line,
> so add the required regulator as well.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

This is not sufficient. Booting with this change results in the following
in dmesg:

musb-sunxi 1c19000.usb: Invalid or missing 'dr_mode' property
musb-sunxi: probe of 1c19000.usb failed with error -22
[...]
usb0-vbus: disabling

... and neither of the USB ports work.

Adding

    dr_mode = "host";

to the &usb_otg node fixes this -- the above messages go away and both
ports work as expected.

-mato
