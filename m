From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 17 Jan 2013 17:25:50 -0800
Subject: [PATCH 3/4 v3] serial: vt8500: UART uses gated clock rather than
 24Mhz reference
In-Reply-To: <1358363143-7154-4-git-send-email-linux@prisktech.co.nz>
References: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
 <1358363143-7154-4-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130118012550.GA28958@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 08:05:42AM +1300, Tony Prisk wrote:
> UART modules on Wondermedia SoCs are connected via a gated clock
> source, rather than directly to the 24Mhz reference clock. While
> uboot enables UART0 for debugging, other UART ports are unavailable
> until the clock is enabled.
> 
> This patch checks that a valid clock is actually passed from devicetree,
> enables the clock in probe. This change removes the fallback when a
> clock was not specified as it doesn't apply any longer (and would only
> work if the UART clock was already enabled).
> 
> DTSI files are updated for VT8500, WM8505 and WM8650.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/boot/dts/vt8500.dtsi      |   40 +++++++++++++++++++++---
>  arch/arm/boot/dts/wm8505.dtsi      |   60 ++++++++++++++++++++++++++++++++----
>  arch/arm/boot/dts/wm8650.dtsi      |   20 ++++++++++--
>  drivers/tty/serial/vt8500_serial.c |   34 +++++++++++---------
>  4 files changed, 127 insertions(+), 27 deletions(-)

PLEASE always use checkpatch.pl on your patches before sending them, so
people don't have to write emails saying "why didn't you fix the
checkpatch.pl errors in your patch" much like this one.

Sorry, not applied.

greg k-h
