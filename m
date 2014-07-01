From: guido@vanguardiasur.com.ar (Guido =?iso-8859-1?Q?Mart=EDnez?=)
Date: Tue, 1 Jul 2014 20:39:58 -0300
Subject: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
In-Reply-To: <53ADEB73.8090301@ti.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <53ADEB73.8090301@ti.com>
Message-ID: <20140701233958.GA31549@fox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 05:08:51PM -0500, Darren Etheridge wrote:
> [snip]
> 
> Otherwise I think this is a good and useful patch series.
It that a Tested-by tag? :)

Thanks!
Guido

> 
> Darren
> 
> >The first 7 patches are bug fixes which and should probably be applied
> >in the stable trees. The last two are clean-ups.
> >
> >
> >Resending this since I got no replies.
> >
> >
> >Guido Mart?nez (9):
> >   drm/i2c: tda998x: move drm_i2c_encoder_destroy call
> >   drm/tilcdc: panel: fix dangling sysfs connector node
> >   drm/tilcdc: slave: fix dangling sysfs connector node
> >   drm/tilcdc: tfp410: fix dangling sysfs connector node
> >   drm/tilcdc: panel: fix leak when unloading the module
> >   drm/tilcdc: fix release order on exit
> >   drm/tilcdc: fix double kfree
> >   drm/tilcdc: remove submodule destroy calls
> >   drm/tilcdc: replace late_initcall with module_init
> >
> >  drivers/gpu/drm/i2c/tda998x_drv.c      |  2 +-
> >  drivers/gpu/drm/tilcdc/Module.symvers  |  0
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 15 +++++--------
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.h    |  1 -
> >  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 39 +++++++++++++++++-----------------
> >  drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 27 +++++++++++++----------
> >  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 35 +++++++++++++++---------------
> >  7 files changed, 59 insertions(+), 60 deletions(-)
> >  create mode 100644 drivers/gpu/drm/tilcdc/Module.symvers
> >

-- 
Guido Mart?nez, VanguardiaSur
www.vanguardiasur.com.ar
