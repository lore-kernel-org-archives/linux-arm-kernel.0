From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Sep 2014 13:40:04 +0100
Subject: [RFC PATCH 05/10] drivers: PL011: refactor pl011_probe()
In-Reply-To: <1411129283-17219-6-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
 <1411129283-17219-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20140919124004.GI5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 01:21:18PM +0100, Andre Przywara wrote:
> Currently the pl011_probe() function is relying on some AMBA IDs
> and a device tree node to initialize the driver and a port.
> Both features are not necessarily required for the driver:
> - we lack AMBA IDs in the ARM SBSA generic UART and
> - we lack a DT node in ACPI systems.
> So lets refactor the function to ease later reuse.

Both features are not "necessary" for any driver, but that doesn't mean
we work around it by throwing a platform driver at it.  We already have
this same problem with PL010 UARTs, and the DT support for AMBA has the
ability to specify the AMBA ID.

Moreover, there is nothing which prevents you from declaring an AMBA
device with an appropriate AMBA ID for the driver to bind to - which is
presumably something very similar to what you're already doing with a
platform device.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
