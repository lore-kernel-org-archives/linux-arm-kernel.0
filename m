From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Nov 2014 18:12:19 +0000
Subject: [PATCH 1/6] clk: sunxi: Add support for sun9i a80 usb clocks and
 resets
In-Reply-To: <1415074039-16590-2-git-send-email-wens@csie.org>
References: <1415074039-16590-1-git-send-email-wens@csie.org>
 <1415074039-16590-2-git-send-email-wens@csie.org>
Message-ID: <20141104181219.GJ4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 12:07:14PM +0800, Chen-Yu Tsai wrote:
> +	spin_lock_irqsave(data->lock, flags);
> +
> +	reg = readl(data->reg);
> +	writel(reg & ~BIT(id), data->reg);
> +
> +	spin_unlock_irqrestore(data->lock, flags);

Don't we have generic support for atomic modification of register
values?  Hmm, we have it for ARM only - atomic_io_modify() and
atomic_io_modify_relaxed().

I guess we should push for those to become cross-arch if we end up
with generic drivers shared between other architectures.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
