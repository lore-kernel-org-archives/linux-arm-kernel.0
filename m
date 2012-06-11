From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Jun 2012 22:42:40 +0800
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201206111253.17314.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
 <201206101353.06018.marex@denx.de>
 <20120611073036.GG2552@S2101-09.ap.freescale.net>
 <201206111253.17314.marex@denx.de>
Message-ID: <20120611144237.GI2552@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 12:53:17PM +0200, Marek Vasut wrote:
> Ok, then can you please try asking them how to exactly compute the values in 
> timing0-timing2 registers? So we don't have to hardcode them like it's done now?
> 
It's determined I2C clock waveform you want to get.  See i.MX28 RM
"Figure 27-2. I2C Data and Clock Timing" and "Figure 27-3. I2C Data
and Clock Timing Generation".

For example, if you run 12MHz APBX clock, and set HIGH_COUNT to 60,
the I2C clock will have 60 cycle x (1/12MHz) = 5us time for its high
period.

-- 
Regards,
Shawn
