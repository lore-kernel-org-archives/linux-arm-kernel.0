From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 3 Feb 2013 20:48:26 +0100
Subject: [PATCH v2] gpio: mvebu: Add clk support to prevent lockup
In-Reply-To: <1359887666-17552-1-git-send-email-andrew@lunn.ch>
References: <1359887666-17552-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130203194825.GB16366@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 03, 2013 at 11:34:26AM +0100, Andrew Lunn wrote:
> The kirkwood SoC GPIO cores use the runit clock. Add code to
> clk_prepare_enable() runit, otherwise there is a danger of locking up
> the SoC by accessing the GPIO registers when runit clock is not
> ticking.
> 
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Tested-by: Simon Baatz <gmbnomis@gmail.com>

After boot (GPIO is the only driver enabling runit at this point in
time):

# cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count
2


- Simon
