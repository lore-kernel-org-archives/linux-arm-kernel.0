From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 19 Sep 2017 05:37:43 +0800
Subject: [nomadik:gemini-dir-685-rt2880 3/11]
 drivers/gpu//drm/tve200/tve200_display.c:339:9: error: passing argument 6 of
 'drm_simple_display_pipe_init' from incompatible pointer type
Message-ID: <201709190534.HfdFvMdS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-rt2880
head:   6ce34a082693ad59265079c059f4a7e18b7ff64e
commit: 4ad0ab91845bcd9dfbdb056459d5c82a13b63e00 [3/11] drm/tve200: Add new driver for TVE200
config: ia64-allyesconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4ad0ab91845bcd9dfbdb056459d5c82a13b63e00
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/gpu//drm/tve200/tve200_display.c: In function 'tve200_display_init':
>> drivers/gpu//drm/tve200/tve200_display.c:339:9: error: passing argument 6 of 'drm_simple_display_pipe_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
            &priv->connector.connector);
            ^
   In file included from drivers/gpu//drm/tve200/tve200_drm.h:97:0,
                    from drivers/gpu//drm/tve200/tve200_display.c:26:
   include/drm/drm_simple_kms_helper.h:121:5: note: expected 'const uint64_t * {aka const long long unsigned int *}' but argument is of type 'struct drm_connector *'
    int drm_simple_display_pipe_init(struct drm_device *dev,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:336:8: error: too few arguments to function 'drm_simple_display_pipe_init'
     ret = drm_simple_display_pipe_init(drm, &priv->pipe,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu//drm/tve200/tve200_drm.h:97:0,
                    from drivers/gpu//drm/tve200/tve200_display.c:26:
   include/drm/drm_simple_kms_helper.h:121:5: note: declared here
    int drm_simple_display_pipe_init(struct drm_device *dev,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/drm_simple_display_pipe_init +339 drivers/gpu//drm/tve200/tve200_display.c

   311	
   312	int tve200_display_init(struct drm_device *drm)
   313	{
   314		struct tve200_drm_dev_private *priv = drm->dev_private;
   315		int ret;
   316		static const u32 formats[] = {
   317			DRM_FORMAT_XRGB8888,
   318			DRM_FORMAT_XBGR8888,
   319			DRM_FORMAT_RGB565,
   320			DRM_FORMAT_BGR565,
   321			DRM_FORMAT_XRGB1555,
   322			DRM_FORMAT_XBGR1555,
   323			/*
   324			 * The controller actually supports any YCbCr ordering,
   325			 * for packed YCbCr. This just lists the orderings that
   326			 * DRM supports.
   327			 */
   328			DRM_FORMAT_YUYV,
   329			DRM_FORMAT_YVYU,
   330			DRM_FORMAT_UYVY,
   331			DRM_FORMAT_VYUY,
   332			/* This uses three planes */
   333			DRM_FORMAT_YUV420,
   334		};
   335	
 > 336		ret = drm_simple_display_pipe_init(drm, &priv->pipe,
   337						   &tve200_display_funcs,
   338						   formats, ARRAY_SIZE(formats),
 > 339						   &priv->connector.connector);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51920 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/563fb0de/attachment-0001.gz>
