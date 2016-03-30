From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Mar 2016 13:53:24 -0700
Subject: [PATCH] ARM: dts: AM43x-epos: Fix clk parent for synctimer
In-Reply-To: <1457420075-26158-1-git-send-email-lokeshvutla@ti.com>
References: <1457420075-26158-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20160330205324.GA9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [160307 22:58]:
> commit 55ee7017ee31 ("arm: omap2: board-generic: use omap4_local_timer_init
> for AM437x") makes synctimer32k as the clocksource on AM43xx. By default
> the synctimer32k is clocked by 32K RTC OSC on AM43xx. But this 32K RTC OSC
> is not available on epos boards which makes it fail to boot.
> 
> Synctimer32k can also be clocked by a peripheral PLL, so making this as
> clock parent for synctimer3k on epos boards.

OK applying into omap-for-v4.6/fixes with Cc: stable v4.4+.

Thanks,

Tony
