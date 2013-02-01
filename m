From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Feb 2013 16:07:49 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130201100329.4d57fa55@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130201035115.GA23649@obsidianresearch.com> <20130201100329.4d57fa55@skate>
Message-ID: <201302011607.49205.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013, Thomas Petazzoni wrote:
> So there is really a range of I/O addresses associated to it, even
> though the device will apparently not use it. Would it be possible to
> detect that the I/O range is not used by the device, and therefore
> avoid the allocation of an address decoding window for this I/O range?

I suspect it just gets disabled because the port number 0xc0010000 is
larger than IO_PORT_LIMIT and we cannot access that offset inside
of the virtual memory window we use for PIO.

	Arnd
