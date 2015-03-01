From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Mar 2015 14:51:57 +0000
Subject: [PATCH] clkdev: clk_add_alias don't put origin clock
In-Reply-To: <1425195815-14895-1-git-send-email-ysato@users.sourceforge.jp>
References: <1425195815-14895-1-git-send-email-ysato@users.sourceforge.jp>
Message-ID: <20150301145157.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 01, 2015 at 04:43:35PM +0900, Yoshinori Sato wrote:
> Refer to 'r' later.
> So don't put in clk_add_alias.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

This isn't how I want to solve this.  I'd much rather we converted clkdev
to use struct clk_hw internally instead.  This is something I'm looking
into at the moment.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
