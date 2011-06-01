From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 09:30:00 +0100
Subject: [PATCH 2/3] clocksource: add DB8500 PRCMU Timer support
In-Reply-To: <BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
References: <1306830661-9546-1-git-send-email-mattias.wallin@stericsson.com>
	<alpine.LFD.2.02.1105311236250.3078@ionos>
	<4DE51EB7.7010606@stericsson.com>
	<BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
Message-ID: <20110601083000.GD3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 11:18:25PM +0200, Linus Walleij wrote:
> Keeping it under include/linux is probably wise since we want drivers
> OUT of the ARM tree, but I don't know if there is much consensus on that?

Header files private to a driver should be alongside the driver.  Look
at drivers/net or drivers/scsi for plenty of examples.

Just because its a header file does not mean it must be in some directory
with 'include' in its path.  The only reason to put it in include/linux
is if it contains stuff which needs to be shared outside of the driver
(eg, with arches).
