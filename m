From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Aug 2015 14:52:58 +0100
Subject: [PATCH] ARM: Fix the secondary_startup function in Big Endian case
In-Reply-To: <1438860452-6347-1-git-send-email-gregory.clement@free-electrons.com>
References: <1438860452-6347-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150806135258.GE7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 01:27:32PM +0200, Gregory CLEMENT wrote:
> Since the commit "b2c3e38a5471 ARM: redo TTBR setup code for LPAE",
> the setup code had been reworked. As a result the secondary CPUs
> failed to come online in Big Endian.
> 
> As explained by Russell, the new code expected the value in r4/r5 to
> be the least significant 32bits in r4 and the most significant 32bits
> in r5. However, in the secondary code, we load this using ldrd, which
> on BE reverses that.
> 
> This patch swap r4/r5 after the ldrd. It is done using the xor
> instructions in order to not use a temporary register.

Patch looks good to me, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
