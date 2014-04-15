From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Apr 2014 11:00:02 +0100
Subject: [PATCH] ARM: prima2: remove L2 cache size override
In-Reply-To: <1397555342-25644-1-git-send-email-21cnbao@gmail.com>
References: <1397555342-25644-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140415100002.GQ24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:49:02PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> L2 cache size has been read by l2x0_init(), it is useless to set
> WAY_SIZE and ASSOCIATIVITY in prima2.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -Derived from Russell's "ARM: l2c: prima2: remove cache size override"

You're a SMP architecture... it would be much better to initialise the
L2 cache before the secondary CPUs are brought online.

In any case, across the board, it's preferable that the L2 cache is
enabled before the delay loop calibration as it can have an effect on
the calibrated value.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
