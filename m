From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 16 Jul 2013 08:59:52 +0200
Subject: [PATCH 00/10] Orion Watchdog fixes
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130716065952.GA25043@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 08:32:33PM -0300, Ezequiel Garcia wrote:
> This patchset introduces a bunch of fixes that removes the direct use of
> the shared timer control register, and also removes the need to include
> a mach-specific header.
> 
> With this changes the driver can be included in multiplatforms builds,
> and in particular be used for the Armada 370/XP SoC.

Hi Ezequiel

Maybe i'm missing something here. You are making use of
orion_timer_ctrl_clrset() from time-orion.c. How will this work on
370/XP which has a different clocksource driver?

Thanks
	Andrew
