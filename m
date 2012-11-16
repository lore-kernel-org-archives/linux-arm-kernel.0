From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Nov 2012 14:13:02 +0100
Subject: [PATCH 1/6] clocksource: sunxi: Add Allwinner A1X Timer Driver
In-Reply-To: <1353019586-21043-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1353019586-21043-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121116141302.65e76897@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Thu, 15 Nov 2012 23:46:20 +0100, Maxime Ripard wrote:

> +#define TIMER_CLKSRC		24000000

You should rather add a DT node for this fixed rate clock, and pass a
clocks = <&fooclk> DT property to your timer DT node, and then in your
timer driver do an of_clk_get() + clk_get_rate() to get the frequency
of this.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
