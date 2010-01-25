From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jan 2010 18:04:40 +0000
Subject: [PATCH] ARM: RealView SD/MMC Card detection and write-protect
	using GPIOLIB
In-Reply-To: <20100125125820.5028.29129.stgit@ARM03585.cambridge.arm.com>
References: <20100125125820.5028.29129.stgit@ARM03585.cambridge.arm.com>
Message-ID: <20100125180440.GD22481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 12:58:20PM +0000, Colin Tuckley wrote:
> The switch to using GPIOLIB broke the sd/mmc card detection on the
> RealView development boards because ARCH_REQUIRE_GPIOLIB
> and GPIO_PL061 were not always selected. Forcing the use of gpiolib also
> means that the write-protect detection works.

No; if it's broken then it's because something's wrong, and I think there
was a mail about that recently.  I don't particularly like forcing options
on when there's better solutions to the problem (like fixing the cause of
the actual breakage.)
