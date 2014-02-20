From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Feb 2014 10:34:26 -0300
Subject: [RFC PATCH 2/2] ARM: imx6q: Mark VPU and IPU AXI transfers as
 cacheable, increase IPU priority
In-Reply-To: <1392896673-13627-2-git-send-email-p.zabel@pengutronix.de>
References: <1392896673-13627-1-git-send-email-p.zabel@pengutronix.de>
 <1392896673-13627-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5C0kcre6=JW=vXSaYL_zydvnwZYCV92Rg1_b=feAGr9qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 8:44 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> This is needed so that the IPU framebuffer scanout cannot be
> starved by VPU or GPU activity.
> Some boards like the SabreLite and SabreSD seem to set this in
> the DCD already, but the documented register reset values do not
> contain the necessary settings.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Yes, better to configure it in the kernel than relying on the
bootloader to do this setup.

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
