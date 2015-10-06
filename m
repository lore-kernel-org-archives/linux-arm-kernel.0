From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 15:00:18 -0300
Subject: [PATCH 05/12] drm: bridge/dw_hdmi: add support for interlaced
 video modes
In-Reply-To: <E1ZO6b3-0002qv-BK@rmk-PC.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6b3-0002qv-BK@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOMZO5BTiiXL2xbHO1VupkXbN=kOm3Amw77c7h2CujrBzQGjDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 8, 2015 at 1:03 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Add support for interlaced video modes to the dw_hdmi bridge.  This
> mainly involves halving the vertical parameters to be programmed into
> the bridge registers, and setting the interlace_allowed connector flag.
>
> This brings working 1080i support.  However, 480i and 576i fail to
> work due to the lack of proper pixel repetition support, which is not
> trivial to add due to the tabular PLL parameterisation.  Hence, we
> filter out these modes in our mode_valid() method.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
