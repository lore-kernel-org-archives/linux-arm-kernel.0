From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Nov 2015 15:37:33 +0100
Subject: [PATCH] ARM: tegra: select USB_ULPI from EHCI rather than platform
In-Reply-To: <8693901.Fc4bDK8zzK@wuerfel>
References: <8693901.Fc4bDK8zzK@wuerfel>
Message-ID: <20151123143733.GA2318@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 02:51:29PM +0100, Arnd Bergmann wrote:
> For historic reasons, the tegra platform selects USB_ULPI from architecture
> code, but that hasn't really made sense for a long time, as the only
> user of that code is the Tegra EHCI driver that has its own Kconfig
> symbol.
> 
> This removes the 'select' statements from mach-tegra and drivers/soc/tegra
> and adds them with the device driver that actually needs them.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Tegra maintainers, can you pick this up for 4.5? There is no real bug here,
> but I found this when looking at something else in drivers/usb/phy.

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/e0c2a08b/attachment.sig>
