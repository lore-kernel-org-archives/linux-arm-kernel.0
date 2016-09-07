From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 7 Sep 2016 08:26:05 +0800
Subject: [arm:drm-tda998x-devel 2/3]
 drivers/gpu/drm/i2c/tda998x_drv.c:1326:2: warning: initialization from
 incompatible pointer type
Message-ID: <201609070857.liwBwL9k%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-tda998x-devel
head:   3e980591945eadbfdf4cbc05d56e5f44010a5a87
commit: 82299b9bb080785cae12273d7796c2b681727e7e [2/3] drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 82299b9bb080785cae12273d7796c2b681727e7e
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i2c/tda998x_drv.c:1326:2: warning: initialization from incompatible pointer type
     .hw_params = tda998x_audio_hw_params,
     ^
   drivers/gpu/drm/i2c/tda998x_drv.c:1326:2: warning: (near initialization for 'audio_codec_ops.hw_params')
   drivers/gpu/drm/i2c/tda998x_drv.c:1327:2: warning: initialization from incompatible pointer type
     .audio_shutdown = tda998x_audio_shutdown,
     ^
   drivers/gpu/drm/i2c/tda998x_drv.c:1327:2: warning: (near initialization for 'audio_codec_ops.audio_shutdown')
   drivers/gpu/drm/i2c/tda998x_drv.c:1328:2: warning: initialization from incompatible pointer type
     .digital_mute = tda998x_audio_digital_mute,
     ^
   drivers/gpu/drm/i2c/tda998x_drv.c:1328:2: warning: (near initialization for 'audio_codec_ops.digital_mute')
   drivers/gpu/drm/i2c/tda998x_drv.c:1329:2: warning: initialization from incompatible pointer type
     .get_eld = tda998x_audio_get_eld,
     ^
   drivers/gpu/drm/i2c/tda998x_drv.c:1329:2: warning: (near initialization for 'audio_codec_ops.get_eld')

vim +1326 drivers/gpu/drm/i2c/tda998x_drv.c

  1310		int ret = -ENODEV;
  1311	
  1312		mutex_lock(&config->mutex);
  1313		list_for_each_entry(connector, &config->connector_list, head) {
  1314			if (&priv->encoder == connector->encoder) {
  1315				memcpy(buf, connector->eld,
  1316				       min(sizeof(connector->eld), len));
  1317				ret = 0;
  1318			}
  1319		}
  1320		mutex_unlock(&config->mutex);
  1321	
  1322		return ret;
  1323	}
  1324	
  1325	static const struct hdmi_codec_ops audio_codec_ops = {
> 1326		.hw_params = tda998x_audio_hw_params,
  1327		.audio_shutdown = tda998x_audio_shutdown,
  1328		.digital_mute = tda998x_audio_digital_mute,
  1329		.get_eld = tda998x_audio_get_eld,
  1330	};
  1331	
  1332	static int tda998x_audio_codec_init(struct tda998x_priv *priv,
  1333					    struct device *dev)
  1334	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45338 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/f0903074/attachment-0001.obj>
