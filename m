From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Jun 2012 11:02:02 +0200
Subject: [PATCH 1/2] ARM:MX28: Add additionnal muxing options to iMX28 DTSI
In-Reply-To: <20120625155047.GD2342@S2101-09.ap.freescale.net>
References: <1340356494-24664-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340356494-24664-2-git-send-email-maxime.ripard@free-electrons.com>
 <20120625155047.GD2342@S2101-09.ap.freescale.net>
Message-ID: <20120626110202.06807982@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

Le Mon, 25 Jun 2012 23:50:49 +0800,
Shawn Guo <shawn.guo@linaro.org> a ?crit :

> then, pinctrl system will be able to report there are 2 pin groups for
> function "duart" in debugfs.

Ah nice, this explains why the mxs pinctrl driver creates a separate
group for each pinctrl DT subnode, but only creates a new function when
the name changes.

However, how would the mxs pinctrl driver handle the following case:

	pinctrl {
		duart_pins_a: duart at 0 {
			...
		}
		something_pins: something at 0 {
			...
		}
		duart_pins_b: duart at 1 {
			...
		}
	}

Reading the driver code, I have the feeling that the logic that creates
the functions will only work if the different groups for a given
function are given as consecutive subnodes in the DT. Is this correct?

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
