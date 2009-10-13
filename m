From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Oct 2009 18:47:22 +0100
Subject: [PATCH v2 1/2] arm: a driver for on-chip ETM and ETB
In-Reply-To: <1255453611-16119-1-git-send-email-virtuoso@slind.org>
References: <1255453611-16119-1-git-send-email-virtuoso@slind.org>
Message-ID: <20091013174722.GB1134@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 08:06:50PM +0300, Alexander Shishkin wrote:
> +	emu_clk = *(struct clk **)pdev->dev.platform_data;
> +	if (emu_clk)
> +		clk_enable(emu_clk);
> +

Definitely no way this is going to be acceptable.  Never EVER pass clk
pointers around like this.

And you've ignored the comments about it being a platform driver.

Sorry, but the answer to this patch is a firm NAK.

Please make it an AMBA primecell driver.  Also make it follow the clk
API correctly, and claim the three clocks for that primecell *only*.
