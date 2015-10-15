From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 11:07:28 +0800
Subject: [alsa-devel] [PATCH v6 09/10] snd: dmaengine-pcm: add
 snd_dmaengine_pcm_get_caps interface
In-Reply-To: <1444872998-2548-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <201510151102.w2eXs34z%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

[auto build test WARNING on rockchip/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Shawn-Lin/Fix-broken-DMAFLUSHP-on-Rockchips-platform/20151015-094613
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> sound/soc/soc-generic-dmaengine-pcm.c:475: warning: No description found for parameter 'caps'

vim +/caps +475 sound/soc/soc-generic-dmaengine-pcm.c

   459			return;
   460	
   461		pcm = soc_platform_to_pcm(platform);
   462	
   463		snd_soc_remove_platform(platform);
   464		dmaengine_pcm_release_chan(pcm);
   465		kfree(pcm);
   466	}
   467	EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
   468	
   469	
   470	/**
   471	 * snd_dmaengine_pcm_get_caps - Get slave dma caps based PCM device
   472	 * @dev: Parent device the PCM was register with
   473	 */
   474	int snd_dmaengine_pcm_get_caps(struct device *dev, struct dma_slave_caps *caps)
 > 475	{
   476		struct snd_soc_platform *platform;
   477		struct dmaengine_pcm *pcm;
   478		int ret = -ENODEV;
   479	
   480		platform = snd_soc_lookup_platform(dev);
   481		if (!platform)
   482			return ret;
   483	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6062 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/4fa333bb/attachment.obj>
