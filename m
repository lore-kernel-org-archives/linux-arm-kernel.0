From: ryan@nardis.ca (Ryan Tandy)
Date: Sun, 8 Jan 2017 09:02:09 -0800
Subject: [PATCH v4 1/2] power: reset: add linkstation-reset driver
In-Reply-To: <20170107150451.17912-2-rogershimizu@gmail.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
Message-ID: <20170108170209.GD573@kiwi.nardis.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Sun, Jan 08, 2017 at 12:04:50AM +0900, Roger Shimizu wrote:
>+config POWER_RESET_LINKSTATION
>+	bool "Buffalo Linkstation and its variants reset driver"
>+	depends on OF_GPIO && PLAT_ORION
>+	help
>+	  This driver supports power off Buffalo Linkstation / KuroBox Pro
>+	  NAS and their variants by sending commands to the micro-controller
>+	  which controls the main power.
>+
>+	  Say Y if you have a Buffalo Linkstation / KuroBox Pro NAS.
>+

Would it make sense to mention something about these being the 
ARM9/orion5x Linkstations? If I understand correctly, the older PPC 
Linkstations have a single-byte poweroff command. (Maybe they could even 
be supported by qnap-poweroff.)

See arch/powerpc/platforms/embedded6xx/linkstation.c around line 123, 
and arch/powerpc/platforms/embedded6xx/ls_uart.c.
