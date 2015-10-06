From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 14:59:16 -0300
Subject: [PATCH 04/12] gpu: imx: fix support for interlaced modes
In-Reply-To: <E1ZO6ay-0002qh-6E@rmk-PC.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6ay-0002qh-6E@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOMZO5D_UXL5mqQFyTPnTu_ixxAfXPq5Qrg4jdVoRdQGUZVeFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 8, 2015 at 1:03 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> The support for interlaced video modes seems to be broken; we don't use
> anything other than the vtotal/htotal from the timing information to
> define the various sync counters.
>
> Freescale patches for interlaced video support contain an alternative
> sync counter setup, which we include here.  This setup produces the
> hsync and vsync via the normal counter 2 and 3, but moves the display
> enable signal from counter 5 to counter 6.  Therefore, we need to
> change the display controller setup as well.
>
> The corresponding Freescale patches for this change are:
>   iMX6-HDMI-support-interlaced-display-mode.patch
>   IPU-fine-tuning-the-interlace-display-timing-for-CEA.patch
>
> This produces a working interlace format output from the IPU.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
