From: laanwj@gmail.com (Wladimir J. van der Laan)
Date: Mon, 21 Aug 2017 17:54:12 +0200
Subject: [PATCH] clk: imx51: propagate rate across ipu_di*_sel
In-Reply-To: <CAOMZO5BoZNQrmDMXE0CDxLS-v7xVu4z87Ezdma1X1QCV56rPtQ@mail.gmail.com>
References: <20170818163058.22252-1-l.stach@pengutronix.de>
 <CAOMZO5BoZNQrmDMXE0CDxLS-v7xVu4z87Ezdma1X1QCV56rPtQ@mail.gmail.com>
Message-ID: <20170821155412.GA24652@amethyst.visucore.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Mon, Aug 21, 2017 at 11:17:01AM -0300, Fabio Estevam wrote:
> On Fri, Aug 18, 2017 at 1:30 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Wladimir,
> 
> Could you please test it and see if it fixes the DVI output issue you
> reported earlier?
> https://lists.freedesktop.org/archives/dri-devel/2017-April/138155.html

I'm trying to, but getting a non-clock-related problem on the i.mx51 babbage board
with current kernel preventing the display from coming up at all:

    [    0.824712] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
    [    0.831411] [drm] No driver support for vblank timestamp query.
    [    0.837632] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
    [    0.845214] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
    [    0.852720] imx-drm display-subsystem: failed to bind display at di0 (ops imx_pd_ops): -19
    [    0.860994] imx-drm display-subsystem: master bind failed: -19

Will try to debug this later.

Regards,
Wladimir
