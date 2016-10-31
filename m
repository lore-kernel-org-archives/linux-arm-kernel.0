From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 16:17:00 +0000
Subject: [Bug] ARM: mxs: STI: console can't wake up from freeze
In-Reply-To: <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
 <20161023133134.GI1041@n2100.armlinux.org.uk>
 <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
Message-ID: <20161031161700.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 01:44:14PM +0200, Stefan Wahren wrote:
> unfortunately not:
> 
> Setting: no_console_suspend not in cmdline, Debug UART wakeup source enabled
> 
> echo mem > /sys/power/state
> 
> Result: Able to wakeup via Debug UART
> Expected result: Able to wakeup via Debug UART
> 
> ---
> 
> Setting: no_console_suspend not in cmdline, Debug UART wakeup source enabled
> 
> echo freeze > /sys/power/state
> 
> Result: Unable to wakeup via Debug UART (no hung task warning)
> Expected result: Able to wakeup via Debug UART

Okay - I know that certain actions are bypassed when no_console_suspend
is set, which has detrimental effects on some ARM platforms, so it was
worth testing - iirc, working no_console_suspend is reliant on the boot
loader re-setting up the serial port after its lost state.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
