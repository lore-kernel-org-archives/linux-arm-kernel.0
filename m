From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 10:19:54 +0100
Subject: [PATCH v3] tty: serial: meson: Implement earlycon support
In-Reply-To: <1456886949-26503-1-git-send-email-afaerber@suse.de>
References: <1456886949-26503-1-git-send-email-afaerber@suse.de>
Message-ID: <2758553.xUr6zr8gHg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 03:49:09 Andreas F?rber wrote:
> Split off the bulk of the existing meson_serial_console_write()
> implementation into meson_serial_port_write() for implementing
> meson_serial_early_console_write().
> 
> Use "meson" as the earlycon driver name, courtesy of Nicolas.
> 
> Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---

I think you also have to add

	select SERIAL_EARLYCON

in the Kconfig file now, to avoid build errors when no other
driver selects that.

	Arnd
