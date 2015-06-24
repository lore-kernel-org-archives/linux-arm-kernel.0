From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Jun 2015 18:29:00 +0100
Subject: L2 Cache enable on i.MX5
In-Reply-To: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
References: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
Message-ID: <20150624172900.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 05:10:26PM +0000, Robert Daniels wrote:
> I recently discovered an issue with an i.MX53 based product where we had
> an older version of Das U-Boot which disabled the L2 cache on startup but
> in a later version would re-enable it once the L2 cache was configured.

The kernel is supposed to be booted with caches disabled, and in particular,
the L2 cache disabled during the decompressor run.

If the L2 cache is configured, it will enable it during it's boot sequence.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
