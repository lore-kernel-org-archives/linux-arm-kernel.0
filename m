From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2016 14:31:35 +0100
Subject: [Bug] ARM: mxs: STI: console can't wake up from freeze
In-Reply-To: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
Message-ID: <20161023133134.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2016 at 11:19:26AM +0200, Stefan Wahren wrote:
> Hi,
> 
> i'm faced with the issue that on i.MX28 the console is unable to wake up from
> freeze ( suspend to idle). I tested it with Linux 4.9-rc1, 4.8 and 3.18 (
> cmdline has
> no_console_suspend=1 ) and also with a i.MX23 with the same result. The suspend
> seems to work, but there is no reaction to the console after the freeze except
> an hung task warning after some time:

I bet if you remove "no_console_suspend" (it's not =1) then it'll work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
