From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 10:26:58 +0200
Subject: [PATCH] watchdog: sunxi: fix activation of system reset
In-Reply-To: <559AC20B.4090601@gmail.com>
References: <559AC20B.4090601@gmail.com>
Message-ID: <20150720082658.GU28632@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Francesco,

Your patch looks mostly good, but there's just a few minor things.

On Mon, Jul 06, 2015 at 07:59:39PM +0200, Francesco Lavra wrote:
> Commit f2147de3 ("watchdog: sunxi: support parameterized compatible

The commit ID should have at least 12 chars to avoid future ID
collisions (which already start to happen)

> strings") introduced a regression in sunxi_wdt_start(), by which
> the system reset function of the watchdog is not enabled upon
> starting the watchdog. Fix it.

Having a description of what that actually means for the end-user (I
guess that it won't reset the system when the watchdog expires) would
be nice.

> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>

Could you also CC stable, and add a Fixes: tag please?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/189aa753/attachment.sig>
