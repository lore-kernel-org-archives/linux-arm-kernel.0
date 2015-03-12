From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 11:04:41 +0000
Subject: [PATCH REPOST 2/2] serial/amba-pl011: Leave the TX IRQ alone
 when the UART is not open
In-Reply-To: <1425472054-7543-3-git-send-email-Dave.Martin@arm.com>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <1425472054-7543-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150312110441.GM8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 12:27:34PM +0000, Dave Martin wrote:
> Getting the TX IRQ re-asserted from scratch can be inefficient in
> some setups.
> 
> This patch avoids clearing the TX IRQ across pl011_shutdown()...
> pl011_startup(), so that if the port is closed and reopened, the
> IRQ will still work afterwards without having to bootstrap it again.

So if a port is being used as the console, we end up spraying the system
with transmit interrupts?  This can't be right.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
