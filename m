From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Jan 2016 18:11:52 +0100
Subject: [PATCH v2 1/7] ARM: dts: kirkwood: gpio pin fixes for
 linkstation ls-wxl/wsxl
In-Reply-To: <1453304038-28345-2-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-2-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160120171152.GN28750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 12:33:52AM +0900, Roger Shimizu wrote:
> For kirkwood, gpio pins starts from 32 are in the 2nd bank, so it should be
> converted to "gpio1 <pin minus 32>" in dts file.
> e.g. gpio 40 should be "gpio1 8"
> 
> Besides, a few other pin fixes for ls-wxl/wsxl, to match with mpp pin
> definition:
>   - gpio-leds: "lswxl:blue:power" pin
>   - gpio-leds: "lswxl:red:func" pin
>   - gpio-leds: "lswxl:red:hdderr0" pin
>   - gpio-leds: "lswxl:red:hdderr1" pin
>   - gpio-fan:  low/high/alarm pin
> 
> The pin/bank issue was found when discussing Debian Bug #810894
>   [https://bugs.debian.org/810894#47]
> 
> Fixes: e54e4b1b622e ("ARM: dts: add buffalo linkstation ls-wxl/wsxl")
> Reported-by: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>

Reviewd-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew
