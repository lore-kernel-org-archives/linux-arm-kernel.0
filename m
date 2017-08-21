From: laanwj@gmail.com (Wladimir J. van der Laan)
Date: Mon, 21 Aug 2017 18:38:24 +0200
Subject: [PATCH] clk: imx51: propagate rate across ipu_di*_sel
In-Reply-To: <4d5dbc0a-56b0-52a3-482d-2b3348c9c53b@cogentembedded.com>
References: <20170818163058.22252-1-l.stach@pengutronix.de>
 <CAOMZO5BoZNQrmDMXE0CDxLS-v7xVu4z87Ezdma1X1QCV56rPtQ@mail.gmail.com>
 <20170821155412.GA24652@amethyst.visucore.com>
 <4d5dbc0a-56b0-52a3-482d-2b3348c9c53b@cogentembedded.com>
Message-ID: <20170821163824.GC24652@amethyst.visucore.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nikita, Fabio,

On Mon, Aug 21, 2017 at 06:58:19PM +0300, Nikita Yushchenko wrote:
> > I'm trying to, but getting a non-clock-related problem on the i.mx51 babbage board
> > with current kernel preventing the display from coming up at all:
> > 
> >     [    0.824712] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> >     [    0.831411] [drm] No driver support for vblank timestamp query.
> >     [    0.837632] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
> >     [    0.845214] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
> >     [    0.852720] imx-drm display-subsystem: failed to bind display at di0 (ops imx_pd_ops): -19
> >     [    0.860994] imx-drm display-subsystem: master bind failed: -19
> 
> I believe this should be fixed by
> 
> commit 799ee2970485dc206c3bf347d6e6827c04d5e4f9
> Author: Philipp Zabel <p.zabel@pengutronix.de>
> Date:   Mon Jun 12 17:54:29 2017 +0200
> 
>   drm/imx: parallel-display: Accept drm_of_find_panel_or_bridge failure

Thanks,
With that patch and Lucas' patch series applied, I can confirm to have working a console on DVI!

Regards,
Wladimir
