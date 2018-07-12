From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Jul 2018 22:31:55 -0700
Subject: [PATCH v3] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
In-Reply-To: <20180711145822.1090-1-neeraj.dantu@octavosystems.com>
References: <20180711145822.1090-1-neeraj.dantu@octavosystems.com>
Message-ID: <20180712053155.GP99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Neeraj Dantu <dantuguf14105@gmail.com> [180711 15:13]:
> OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> Octavo Systems.
...
> - Fix HDMI encoder node name

I think you got this the wrong way around :) See below.

> +&i2c0 {
> +	hdmiencoder: tda19988 {
> +		compatible = "nxp,tda998x";

	tda19988: hdmiencoder {
		...
	};

So the generic type for the node. Please check the
other devices for that too.

Regards,

Tony
