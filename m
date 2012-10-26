From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Oct 2012 20:51:17 -0600
Subject: [PATCH] ARM: bcm2835: implement machine restart hook
In-Reply-To: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
References: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5089FAA5.7050908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2012 10:08 PM, Stephen Warren wrote:
> Implement the machine restart hook using the SoC's watchdog timer module.
> To support this, define a DT binding for the watchdog module, and add it
> to the device tree.
> 
> The downstream rpi-split branch contains a full watchdog timer driver
> implementation, which also implements the restart hook. However, the
> restart function is largely separate from the watchdog driver, so for
> simplicity, the restart hook is implemented here directly in the main
> machine source file.
> 
> Overall structure (separate setup/restart) functions derived from the
> picoxcell ARM support.
> 
> Watchdog register IO sequence taken from code by Simon Arlott. Note that
> the watchdog module is not documented in BCM2835-ARM-Peripherals.pdf.

Applied to rpi's for-3.8/soc branch.
