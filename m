From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Sep 2016 08:34:53 +0800
Subject: [PATCH 5/5] drm/rockchip: Add dmc notifier in vop driver
In-Reply-To: <1472769085-20715-6-git-send-email-hl@rock-chips.com>
Message-ID: <201609020840.6FaQa5pQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

[auto build test ERROR on next-20160825]
[cannot apply to rockchip/for-next devfreq/for-rafael linus/master v4.8-rc4 v4.8-rc3 v4.8-rc2 v4.8-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160902-063701
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/rockchip/rockchip_drm_vop.c:23:0:
   include/linux/devfreq-event.h:190:21: error: redefinition of 'devfreq_event_get_drvdata'
    static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
                        ^
   include/linux/devfreq-event.h:151:21: note: previous definition of 'devfreq_event_get_drvdata' was here
    static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
                        ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c: In function 'vop_crtc_disable':
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:653:13: error: invalid storage class for function 'vop_plane_destroy'
    static void vop_plane_destroy(struct drm_plane *plane)
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:653:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void vop_plane_destroy(struct drm_plane *plane)
    ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:658:12: error: invalid storage class for function 'vop_plane_prepare_fb'
    static int vop_plane_prepare_fb(struct drm_plane *plane,
               ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:667:13: error: invalid storage class for function 'vop_plane_cleanup_fb'
    static void vop_plane_cleanup_fb(struct drm_plane *plane,
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:674:12: error: invalid storage class for function 'vop_plane_atomic_check'
    static int vop_plane_atomic_check(struct drm_plane *plane,
               ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:731:13: error: invalid storage class for function 'vop_plane_atomic_disable'
    static void vop_plane_atomic_disable(struct drm_plane *plane,
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:756:13: error: invalid storage class for function 'vop_plane_atomic_update'
    static void vop_plane_atomic_update(struct drm_plane *plane,
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:866:16: error: initializer element is not constant
     .prepare_fb = vop_plane_prepare_fb,
                   ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:866:16: note: (near initialization for 'plane_helper_funcs.prepare_fb')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:867:16: error: initializer element is not constant
     .cleanup_fb = vop_plane_cleanup_fb,
                   ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:867:16: note: (near initialization for 'plane_helper_funcs.cleanup_fb')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:868:18: error: initializer element is not constant
     .atomic_check = vop_plane_atomic_check,
                     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:868:18: note: (near initialization for 'plane_helper_funcs.atomic_check')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:869:19: error: initializer element is not constant
     .atomic_update = vop_plane_atomic_update,
                      ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:869:19: note: (near initialization for 'plane_helper_funcs.atomic_update')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:870:20: error: initializer element is not constant
     .atomic_disable = vop_plane_atomic_disable,
                       ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:870:20: note: (near initialization for 'plane_helper_funcs.atomic_disable')
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:873:13: error: invalid storage class for function 'vop_atomic_plane_reset'
    static void vop_atomic_plane_reset(struct drm_plane *plane)
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:891:1: error: invalid storage class for function 'vop_atomic_plane_duplicate_state'
    vop_atomic_plane_duplicate_state(struct drm_plane *plane)
    ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:911:13: error: invalid storage class for function 'vop_atomic_plane_destroy_state'
    static void vop_atomic_plane_destroy_state(struct drm_plane *plane,
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:924:13: error: initializer element is not constant
     .destroy = vop_plane_destroy,
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:924:13: note: (near initialization for 'vop_plane_funcs.destroy')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:925:11: error: initializer element is not constant
     .reset = vop_atomic_plane_reset,
              ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:925:11: note: (near initialization for 'vop_plane_funcs.reset')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:926:28: error: initializer element is not constant
     .atomic_duplicate_state = vop_atomic_plane_duplicate_state,
                               ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:926:28: note: (near initialization for 'vop_plane_funcs.atomic_duplicate_state')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:927:26: error: initializer element is not constant
     .atomic_destroy_state = vop_atomic_plane_destroy_state,
                             ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:927:26: note: (near initialization for 'vop_plane_funcs.atomic_destroy_state')
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:930:12: error: invalid storage class for function 'vop_crtc_enable_vblank'
    static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
               ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:947:13: error: invalid storage class for function 'vop_crtc_disable_vblank'
    static void vop_crtc_disable_vblank(struct drm_crtc *crtc)
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:962:13: error: invalid storage class for function 'vop_crtc_wait_for_update'
    static void vop_crtc_wait_for_update(struct drm_crtc *crtc)
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:971:19: error: initializer element is not constant
     .enable_vblank = vop_crtc_enable_vblank,
                      ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:971:19: note: (near initialization for 'private_crtc_funcs.enable_vblank')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:972:20: error: initializer element is not constant
     .disable_vblank = vop_crtc_disable_vblank,
                       ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:972:20: note: (near initialization for 'private_crtc_funcs.disable_vblank')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:973:21: error: initializer element is not constant
     .wait_for_update = vop_crtc_wait_for_update,
                        ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:973:21: note: (near initialization for 'private_crtc_funcs.wait_for_update')
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:976:13: error: invalid storage class for function 'vop_crtc_mode_fixup'
    static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:988:13: error: invalid storage class for function 'vop_crtc_enable'
    static void vop_crtc_enable(struct drm_crtc *crtc)
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1090:13: error: invalid storage class for function 'vop_crtc_atomic_flush'
    static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1105:13: error: invalid storage class for function 'vop_crtc_atomic_begin'
    static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
                ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1122:12: error: initializer element is not constant
     .enable = vop_crtc_enable,
               ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1122:12: note: (near initialization for 'vop_crtc_helper_funcs.enable')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1124:16: error: initializer element is not constant
     .mode_fixup = vop_crtc_mode_fixup,
                   ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1124:16: note: (near initialization for 'vop_crtc_helper_funcs.mode_fixup')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1125:18: error: initializer element is not constant
     .atomic_flush = vop_crtc_atomic_flush,
                     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1125:18: note: (near initialization for 'vop_crtc_helper_funcs.atomic_flush')
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1126:18: error: initializer element is not constant
     .atomic_begin = vop_crtc_atomic_begin,
                     ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1126:18: note: (near initialization for 'vop_crtc_helper_funcs.atomic_begin')
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1129:13: error: invalid storage class for function 'vop_crtc_destroy'
    static void vop_crtc_destroy(struct drm_crtc *crtc)
                ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1134:13: error: invalid storage class for function 'vop_crtc_reset'
    static void vop_crtc_reset(struct drm_crtc *crtc)
                ^

vim +/vop_plane_destroy +653 drivers/gpu/drm/rockchip/rockchip_drm_vop.c

4bb85264 Lin Huang     2016-09-02  647  		if (vop->devfreq_event_dev)
4bb85264 Lin Huang     2016-09-02  648  			devfreq_event_enable_edev(vop->devfreq_event_dev);
4bb85264 Lin Huang     2016-09-02  649  		devfreq_resume_device(vop->devfreq);
893b6cad Daniel Vetter 2016-06-08  650  	}
2048e328 Mark Yao      2014-08-22  651  }
2048e328 Mark Yao      2014-08-22  652  
63ebb9fa Mark Yao      2015-11-30 @653  static void vop_plane_destroy(struct drm_plane *plane)
2048e328 Mark Yao      2014-08-22  654  {
63ebb9fa Mark Yao      2015-11-30  655  	drm_plane_cleanup(plane);
2048e328 Mark Yao      2014-08-22  656  }
2048e328 Mark Yao      2014-08-22  657  
44d0237a Mark Yao      2016-04-29 @658  static int vop_plane_prepare_fb(struct drm_plane *plane,
1832040d Chris Wilson  2016-08-18  659  				struct drm_plane_state *new_state)
44d0237a Mark Yao      2016-04-29  660  {
44d0237a Mark Yao      2016-04-29  661  	if (plane->state->fb)
44d0237a Mark Yao      2016-04-29  662  		drm_framebuffer_reference(plane->state->fb);
44d0237a Mark Yao      2016-04-29  663  
44d0237a Mark Yao      2016-04-29  664  	return 0;
44d0237a Mark Yao      2016-04-29  665  }
44d0237a Mark Yao      2016-04-29  666  
44d0237a Mark Yao      2016-04-29 @667  static void vop_plane_cleanup_fb(struct drm_plane *plane,
1832040d Chris Wilson  2016-08-18  668  				 struct drm_plane_state *old_state)
44d0237a Mark Yao      2016-04-29  669  {
44d0237a Mark Yao      2016-04-29  670  	if (old_state->fb)
44d0237a Mark Yao      2016-04-29  671  		drm_framebuffer_unreference(old_state->fb);
44d0237a Mark Yao      2016-04-29  672  }
44d0237a Mark Yao      2016-04-29  673  
63ebb9fa Mark Yao      2015-11-30 @674  static int vop_plane_atomic_check(struct drm_plane *plane,
63ebb9fa Mark Yao      2015-11-30  675  			   struct drm_plane_state *state)
2048e328 Mark Yao      2014-08-22  676  {
63ebb9fa Mark Yao      2015-11-30  677  	struct drm_crtc *crtc = state->crtc;
92915da6 John Keeping  2016-03-04  678  	struct drm_crtc_state *crtc_state;
63ebb9fa Mark Yao      2015-11-30  679  	struct drm_framebuffer *fb = state->fb;
2048e328 Mark Yao      2014-08-22  680  	struct vop_win *vop_win = to_vop_win(plane);
63ebb9fa Mark Yao      2015-11-30  681  	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
2048e328 Mark Yao      2014-08-22  682  	const struct vop_win_data *win = vop_win->data;
2048e328 Mark Yao      2014-08-22  683  	int ret;
63ebb9fa Mark Yao      2015-11-30  684  	struct drm_rect clip;
4c156c21 Mark Yao      2015-06-26  685  	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
4c156c21 Mark Yao      2015-06-26  686  					DRM_PLANE_HELPER_NO_SCALING;
4c156c21 Mark Yao      2015-06-26  687  	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
4c156c21 Mark Yao      2015-06-26  688  					DRM_PLANE_HELPER_NO_SCALING;
2048e328 Mark Yao      2014-08-22  689  
63ebb9fa Mark Yao      2015-11-30  690  	if (!crtc || !fb)
63ebb9fa Mark Yao      2015-11-30  691  		goto out_disable;
92915da6 John Keeping  2016-03-04  692  
92915da6 John Keeping  2016-03-04  693  	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
92915da6 John Keeping  2016-03-04  694  	if (WARN_ON(!crtc_state))
92915da6 John Keeping  2016-03-04  695  		return -EINVAL;
92915da6 John Keeping  2016-03-04  696  
63ebb9fa Mark Yao      2015-11-30  697  	clip.x1 = 0;
63ebb9fa Mark Yao      2015-11-30  698  	clip.y1 = 0;
92915da6 John Keeping  2016-03-04  699  	clip.x2 = crtc_state->adjusted_mode.hdisplay;
92915da6 John Keeping  2016-03-04  700  	clip.y2 = crtc_state->adjusted_mode.vdisplay;
63ebb9fa Mark Yao      2015-11-30  701  
f9b96be0 Ville Syrj?l? 2016-07-26  702  	ret = drm_plane_helper_check_state(state, &clip,
f9b96be0 Ville Syrj?l? 2016-07-26  703  					   min_scale, max_scale,
f9b96be0 Ville Syrj?l? 2016-07-26  704  					   true, true);
2048e328 Mark Yao      2014-08-22  705  	if (ret)
2048e328 Mark Yao      2014-08-22  706  		return ret;
2048e328 Mark Yao      2014-08-22  707  
f9b96be0 Ville Syrj?l? 2016-07-26  708  	if (!state->visible)
63ebb9fa Mark Yao      2015-11-30  709  		goto out_disable;
84c7f8ca Mark Yao      2015-07-20  710  
63ebb9fa Mark Yao      2015-11-30  711  	vop_plane_state->format = vop_convert_format(fb->pixel_format);
63ebb9fa Mark Yao      2015-11-30  712  	if (vop_plane_state->format < 0)
63ebb9fa Mark Yao      2015-11-30  713  		return vop_plane_state->format;
2048e328 Mark Yao      2014-08-22  714  
84c7f8ca Mark Yao      2015-07-20  715  	/*
84c7f8ca Mark Yao      2015-07-20  716  	 * Src.x1 can be odd when do clip, but yuv plane start point
84c7f8ca Mark Yao      2015-07-20  717  	 * need align with 2 pixel.
84c7f8ca Mark Yao      2015-07-20  718  	 */
f9b96be0 Ville Syrj?l? 2016-07-26  719  	if (is_yuv_support(fb->pixel_format) && ((state->src.x1 >> 16) % 2))
63ebb9fa Mark Yao      2015-11-30  720  		return -EINVAL;
84c7f8ca Mark Yao      2015-07-20  721  
63ebb9fa Mark Yao      2015-11-30  722  	vop_plane_state->enable = true;
2048e328 Mark Yao      2014-08-22  723  
63ebb9fa Mark Yao      2015-11-30  724  	return 0;
2048e328 Mark Yao      2014-08-22  725  
63ebb9fa Mark Yao      2015-11-30  726  out_disable:
63ebb9fa Mark Yao      2015-11-30  727  	vop_plane_state->enable = false;
63ebb9fa Mark Yao      2015-11-30  728  	return 0;
63ebb9fa Mark Yao      2015-11-30  729  }
2048e328 Mark Yao      2014-08-22  730  
63ebb9fa Mark Yao      2015-11-30 @731  static void vop_plane_atomic_disable(struct drm_plane *plane,
63ebb9fa Mark Yao      2015-11-30  732  				     struct drm_plane_state *old_state)
63ebb9fa Mark Yao      2015-11-30  733  {
63ebb9fa Mark Yao      2015-11-30  734  	struct vop_plane_state *vop_plane_state = to_vop_plane_state(old_state);
63ebb9fa Mark Yao      2015-11-30  735  	struct vop_win *vop_win = to_vop_win(plane);
63ebb9fa Mark Yao      2015-11-30  736  	const struct vop_win_data *win = vop_win->data;
63ebb9fa Mark Yao      2015-11-30  737  	struct vop *vop = to_vop(old_state->crtc);
2048e328 Mark Yao      2014-08-22  738  
63ebb9fa Mark Yao      2015-11-30  739  	if (!old_state->crtc)
63ebb9fa Mark Yao      2015-11-30  740  		return;
84c7f8ca Mark Yao      2015-07-20  741  
4f9d39a7 Daniel Vetter 2016-06-08  742  	spin_lock_irq(&plane->dev->event_lock);
4f9d39a7 Daniel Vetter 2016-06-08  743  	vop_win->enable = false;
4f9d39a7 Daniel Vetter 2016-06-08  744  	vop_win->yrgb_mst = 0;
4f9d39a7 Daniel Vetter 2016-06-08  745  	spin_unlock_irq(&plane->dev->event_lock);
4f9d39a7 Daniel Vetter 2016-06-08  746  
63ebb9fa Mark Yao      2015-11-30  747  	spin_lock(&vop->reg_lock);
63ebb9fa Mark Yao      2015-11-30  748  
63ebb9fa Mark Yao      2015-11-30  749  	VOP_WIN_SET(vop, win, enable, 0);
84c7f8ca Mark Yao      2015-07-20  750  
63ebb9fa Mark Yao      2015-11-30  751  	spin_unlock(&vop->reg_lock);
84c7f8ca Mark Yao      2015-07-20  752  
63ebb9fa Mark Yao      2015-11-30  753  	vop_plane_state->enable = false;
84c7f8ca Mark Yao      2015-07-20  754  }
84c7f8ca Mark Yao      2015-07-20  755  
63ebb9fa Mark Yao      2015-11-30 @756  static void vop_plane_atomic_update(struct drm_plane *plane,
63ebb9fa Mark Yao      2015-11-30  757  		struct drm_plane_state *old_state)
63ebb9fa Mark Yao      2015-11-30  758  {
63ebb9fa Mark Yao      2015-11-30  759  	struct drm_plane_state *state = plane->state;

:::::: The code at line 653 was first introduced by commit
:::::: 63ebb9fa7ff06d194362ed4a5d0a31ac7612a89c drm/rockchip: Convert to support atomic API

:::::: TO: Mark Yao <mark.yao@rock-chips.com>
:::::: CC: Mark Yao <mark.yao@rock-chips.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 38827 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/2bea9fd4/attachment-0001.obj>
