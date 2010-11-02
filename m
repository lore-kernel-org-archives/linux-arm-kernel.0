From: notasas@gmail.com (Grazvydas Ignotas)
Date: Tue, 2 Nov 2010 19:21:57 +0200
Subject: [PATCH 1/3] OMAP: DSS2: Add dummy panel display driver
In-Reply-To: <1288714390-6159-2-git-send-email-bryan.wu@canonical.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
	<1288714390-6159-2-git-send-email-bryan.wu@canonical.com>
Message-ID: <AANLkTikd-hMcFkanO4SUceJuvrMoLxxcB4Fw3HvU_8-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 2, 2010 at 6:13 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> Dummy panel driver includes the driver and 4 similar panel configurations. It
> will match the panel name which is passed from platform data and setup the
> right configurations.
>
> With dummy panel driver, we can remove those 4 duplicated panel display
> drivers. In the future, it is simple for us just add new panel configuration
> date in panel-dummy.h to support new display panel.
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

<snip>

> diff --git a/drivers/video/omap2/displays/panel-dummy.h b/drivers/video/omap2/displays/panel-dummy.h
> new file mode 100644
> index 0000000..ac2b7a2
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-dummy.h

There is no benefit of having this header, just add all data directly
in .c file.

<snip>

> + ? ? ? /* Sharp LQ043T1DG01 */
> + ? ? ? {
> + ? ? ? ? ? ? ? { ? ? ? .x_res ? ? ? ? ?= 480,
> + ? ? ? ? ? ? ? ? ? ? ? .y_res ? ? ? ? ?= 272,

missing newline after {
