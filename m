From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 15 Mar 2017 22:11:49 +0100
Subject: [PATCH 2/2 RESEND] power: reset: Add a driver for the Gemini
 poweroff
In-Reply-To: <20170312223621.3010-1-linus.walleij@linaro.org>
References: <20170312223621.3010-1-linus.walleij@linaro.org>
Message-ID: <20170315211149.of3xvrnlq7ne7r5w@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Mar 12, 2017 at 11:36:21PM +0100, Linus Walleij wrote:
> The Gemini (SL3516) SoC has a special power controller block
> that only deal with shutting down the system.
> 
> If you do not register a driver and activate the block, the
> power button on the systems utilizing this SoC will do an
> uncontrolled power cut, which is why it is important to have
> a special poweroff driver.
> 
> The most basic functionality is to just shut down the system
> by writing a special bit in the control register after the
> system has reached pm_poweroff.
> 
> It also handles the poweroff from a button or other sources:
> 
> When the poweroff button is pressed, or a signal is sent to
> poweroff from an infrared remote control, or when the RTC
> fires a special alarm (!) the system emits an interrupt.
> At this point, Linux must acknowledge the interrupt and
> proceed to do an orderly shutdown of the system.
> 
> After adding this driver, pressing the poweroff button gives
> this dmesg:
> 
> root at gemini:/
> root at gemini:/ gemini-poweroff 4b000000.power-controller:
> poweroff button pressed
> 
> calling shutdown scripts..
> setting /dev/rtc0 from system time
> unmounting file systems...
> umount: tmpfs busy - remounted read-only
> umount: can't unmount /: Invalid argument
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system poweroff
> uhci_hcd 0000:00:09.1: HCRESET not completed yet!
> uhci_hcd 0000:00:09.0: HCRESET not completed yet!
> reboot: Power down
> gemini-poweroff 4b000000.power-controller: Gemini power off
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-pm at vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Sebastian: please just merge this when your are pleased
> with it. I will funnel the ARM parts through the ARM SoC tree.

DONE.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/b19df2da/attachment.sig>
