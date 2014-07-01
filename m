From: guido@vanguardiasur.com.ar (Guido =?iso-8859-1?Q?Mart=EDnez?=)
Date: Tue, 1 Jul 2014 20:52:00 -0300
Subject: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <20140701235200.GB31549@fox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

did you take a look at this patchset? I foolishly missed adding you on
the To: header, so apologies for that in advance.

Thanks,

On Tue, Jun 17, 2014 at 11:17:02AM -0300, Guido Mart?nez wrote:
> The tilcdc driver could be compiled as a module, but was severely broken
> and could not be used as such. This patchset attempts to fix the issues
> preventing a proper load/unload of the module.
> 
> Issues included dangling sysfs nodes, dangling devices, memory leaks and
> a double kfree.
> 
> It now seems to be working ok. We have tested this by loading and
> unloading the driver repeteadly, with both panel and slave connectors
> and found no flaws.
> 
> There is still one warning left on tilcdc_crtc_destroy, caused by
> destroying the connector while still in an ON status. We don't know why
> this happens or why it's an issue, so we did not fix it.
> 
> The first 7 patches are bug fixes which and should probably be applied
> in the stable trees. The last two are clean-ups.
> 
> 
> Resending this since I got no replies.
> 
> 
> Guido Mart?nez (9):
>   drm/i2c: tda998x: move drm_i2c_encoder_destroy call
>   drm/tilcdc: panel: fix dangling sysfs connector node
>   drm/tilcdc: slave: fix dangling sysfs connector node
>   drm/tilcdc: tfp410: fix dangling sysfs connector node
>   drm/tilcdc: panel: fix leak when unloading the module
>   drm/tilcdc: fix release order on exit
>   drm/tilcdc: fix double kfree
>   drm/tilcdc: remove submodule destroy calls
>   drm/tilcdc: replace late_initcall with module_init
> 
>  drivers/gpu/drm/i2c/tda998x_drv.c      |  2 +-
>  drivers/gpu/drm/tilcdc/Module.symvers  |  0
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 15 +++++--------
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h    |  1 -
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 39 +++++++++++++++++-----------------
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 27 +++++++++++++----------
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 35 +++++++++++++++---------------
>  7 files changed, 59 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/gpu/drm/tilcdc/Module.symvers
> 
> -- 
> 2.0.0
> 

-- 
Guido Mart?nez, VanguardiaSur
www.vanguardiasur.com.ar
