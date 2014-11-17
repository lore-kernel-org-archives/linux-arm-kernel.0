From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 15:51:50 +0000
Subject: [PATCH V2 1/5] serial: pxa: prepare/unprepare clocks
In-Reply-To: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141117155150.GV4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 06:07:39PM +0300, Dmitry Eremin-Solenikov wrote:
> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().

NAK.  Console writes can be called from IRQs-off regions.  clk_prepare()
can sleep.  Sleeping is not permitted with IRQs off.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
