From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 12:23:54 -0700
Subject: [PATCH 2/4] wl1251: move power GPIO handling into the driver
In-Reply-To: <CANOLnONKcC1i19ypb4rh2Rff3WsVhhuUhNvZvYwDV2-ZNtjVxQ@mail.gmail.com>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-3-git-send-email-sre@debian.org>
 <1382891056.102746625@f315.i.mail.ru>
 <20131027201218.GA4414@earth.universe>
 <CANOLnONKcC1i19ypb4rh2Rff3WsVhhuUhNvZvYwDV2-ZNtjVxQ@mail.gmail.com>
Message-ID: <20131028192354.GA18208@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 07:29:52PM +0200, Grazvydas Ignotas wrote:

> When wl12xx family of chips is connected through SDIO, we already have
> that pin set up as a regulator controlled with the help of mmc
> subsystem. When time comes to communicate with the chip, mmc subsystem
> sees this as yet another SD card and looks for associated regulator
> for it, and the board file has that set up as a fixed regulator
> controlling that pin (see pandora_vmmc3 in
> arch/arm/mach-omap2/board-omap3pandora.c). To prevent poweroff after
> first SDIO communications are over, pm_runtime calls are used in
> drivers/net/wireless/ti/wl1251/sdio.c .

Is this actually controlling VMMC though, or is it some other control?
If it's not controlling VMMC then it shouldn't say that it is.

> I don't know if something similar can be done done in SPI case, but
> I'm sure this is not the first your-so-called regulator misuse.

It's not the first but that doesn't make controlling something other
than a regulator through the regulator API any less broken.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/67407f96/attachment.sig>
