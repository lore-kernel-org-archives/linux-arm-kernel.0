From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 17:23:37 +0000
Subject: [PATCH] ARM: at91: sama5d4: Properly configure L2CC
In-Reply-To: <1425468563-14300-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425468563-14300-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150309172337.GA8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 12:29:23PM +0100, Alexandre Belloni wrote:
> As the bootloader may not properly configure the L2CC, enforce its configuration
> in the kernel.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

And I assume you never bothered to read the kernel messages which result
from this?  I guess this means I need to ensure that the kernel freezes
if you do this kind of thing so you can't ignore the complaints from
the L2C code.

It would be much better if you configured the L2C in the boot loader/
board firmware rather than trying to have the kernel do it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
