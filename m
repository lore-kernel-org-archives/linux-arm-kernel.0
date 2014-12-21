From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 21 Dec 2014 15:04:13 +0100
Subject: [PATCH] ARM: dts: Bump SD card pin drive strength up on rk3288-evb
In-Reply-To: <1418244929-8254-1-git-send-email-dianders@chromium.org>
References: <1418244929-8254-1-git-send-email-dianders@chromium.org>
Message-ID: <2971473.Y1akaDeraL@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 10. Dezember 2014, 12:55:29 schrieb Doug Anderson:
> It seems that ever since (536f6b9 mmc: dw_mmc: Reset DMA before
> enabling IDMAC) landed upstream that SD cards have been very unhappy
> on rk3288-evb.  They were a little unhappy before that change, but
> after that change they're REALLY unhappy.
> 
> It turns out that the above fix happens to fix a corruption when
> reading card information during probe time.  Without the fix we didn't
> detect that high speed SD cards could actually support high speed.
> With the fix we suddenly detect that they're high speed and we try to
> use them at 50MHz.  That doesn't work so well on EVB with the default
> drive strength (maybe because there are two physical SD card slots
> hooked up to the same pin?).
> 
> Fix the problem by bumping up the drive strength of the sdmmc lines.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Fixes: 536f6b91d21b ("mmc: dw_mmc: Reset DMA before enabling IDMAC")

applied to my 3.19 dts-fixes branch
(after a slight modification of the subject: please use "ARM: dts: rockchip:")


Heiko
