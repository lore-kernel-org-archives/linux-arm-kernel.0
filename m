From: notasas@gmail.com (Grazvydas Ignotas)
Date: Tue, 2 Nov 2010 19:11:13 +0200
Subject: [PATCH 2/3] OMAP: DSS2: remove dummy panel driver duplicated
	panel drivers
In-Reply-To: <1288714390-6159-3-git-send-email-bryan.wu@canonical.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
	<1288714390-6159-3-git-send-email-bryan.wu@canonical.com>
Message-ID: <AANLkTikXAmgxmA9eBqRceJuvMS+cNGk_NQo_R6TpcpQR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 2, 2010 at 6:13 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> Still keep sharp_ls_panel driver, because it contains blacklight control driver.
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
> ?drivers/video/omap2/displays/Kconfig ? ? ? ? ? ? ? | ? 18 -
> ?drivers/video/omap2/displays/Makefile ? ? ? ? ? ? ?| ? ?3 -
> ?drivers/video/omap2/displays/panel-generic.c ? ? ? | ?174 -------
> ?.../video/omap2/displays/panel-sharp-lq043t1dg01.c | ?165 ------
> ?.../video/omap2/displays/panel-tpo-td043mtea1.c ? ?| ?535 --------------------
> ?5 files changed, 0 insertions(+), 895 deletions(-)
> ?delete mode 100644 drivers/video/omap2/displays/panel-generic.c
> ?delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> ?delete mode 100644 drivers/video/omap2/displays/panel-tpo-td043mtea1.c

Hey don't remove panel-tpo-td043mtea1.c, it's not a dupe! You probably
confused it with panel-toppoly-tdo35s.c . This shows you did not build
test all panel drivers, just select them all in config (enable SPI so
they all appear).
