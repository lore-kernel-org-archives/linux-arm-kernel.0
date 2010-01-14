From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jan 2010 22:33:35 +0000
Subject: Problem with CPU Data cache
In-Reply-To: <a9e22dff1001141406q41fb3a67t27b636256d6e3f7f@mail.gmail.com>
References: <OFD82C1D12.7D7C4E53-ON6525768E.00444887-6525768E.0046F2BF@lntemsys.com>
	<a9e22dff1001141406q41fb3a67t27b636256d6e3f7f@mail.gmail.com>
Message-ID: <20100114223335.GF21385@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2010 at 12:06:27AM +0200, Ni at m wrote:
> Apparently I'm also affected by almost similar problem with arm-946(no
> MMU, MPU only) with 2.6.25 kernel. When data cache is enabled the
> kernel is not able to decompress ramfs(crc error). Interesting that
> this happens only if compressed ramfs is not 4-bytes aligned.

The only thing I can say is that the kernel decompressor is a good test
of system memory hardware.  If you get CRC errors, you should investigate
your hardware.  Normally, it's caused by marginal or noisy SDRAM signals.

(It is also possible that the kernel image may have been corrupted by
the boot loader, but so far we haven't ever had a case of this.)
