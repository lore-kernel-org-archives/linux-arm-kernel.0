From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Feb 2014 15:03:45 +0100
Subject: [PATCH v2 20/23] ARM: config: Add a multi_v5_defconfig
In-Reply-To: <1392459621-24003-21-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-21-git-send-email-andrew@lunn.ch>
Message-ID: <3111881.Wp1d8VNNp3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 February 2014 11:20:18 Andrew Lunn wrote:
> To allow regression build testing of multi v5 systems, add a
> multi_v5_defconfig, similar to the multi_v7_defconfig. This is based
> on kirkwood_defconfig, but with a few other boards added which claim
> to be MULTI_v5.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

How about making this a multi_v4_v5_defconfig? We have a much smaller
number of v4/v4t platforms (moxart, i.MX1) that are multiplatform capable or
could besome so in the future (clps711x, gemini, at91rm9200,
some s3c24xx, omap15xx, integrator) compared to the multitude of v5
platforms, so it might not be useful to start a separate
multi_v4_defconfig.

OTOH if there is a significant performance impact in enabling
CPU_32v4 and CPU_32v4T, we probably want to keep them separate.

Any opinions?

	Arnd
