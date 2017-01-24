From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Jan 2017 10:14:45 +0800
Subject: [alsa-devel] [PATCH 5/7] ASoC: dmaengine_pcm: add copy support
In-Reply-To: <1485189145-29576-6-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201701241000.457WwRYd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi olivier,

[auto build test WARNING on iio/togreg]
[cannot apply to asoc/for-next ljones-mfd/for-mfd-next v4.10-rc5 next-20170123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170124-065537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> include/sound/dmaengine_pcm.h:152: warning: No description found for parameter 'copy'
   include/sound/compress_driver.h:162: warning: No description found for parameter 'id[64]'
   include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_root'
   include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_info_entry'
   include/sound/core.h:323: warning: No description found for parameter '...'
   include/sound/core.h:334: warning: No description found for parameter '...'
   include/sound/core.h:387: warning: No description found for parameter '...'

vim +/copy +152 include/sound/dmaengine_pcm.h

28c4468b Lars-Peter Clausen 2013-04-15  136  struct snd_dmaengine_pcm_config {
28c4468b Lars-Peter Clausen 2013-04-15  137  	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
28c4468b Lars-Peter Clausen 2013-04-15  138  			struct snd_pcm_hw_params *params,
28c4468b Lars-Peter Clausen 2013-04-15  139  			struct dma_slave_config *slave_config);
553a8492 olivier moysan     2017-01-23  140  	int (*copy)(struct snd_pcm_substream *substream, int channel,
553a8492 olivier moysan     2017-01-23  141  		    snd_pcm_uframes_t pos,
553a8492 olivier moysan     2017-01-23  142  		    void __user *buf, snd_pcm_uframes_t count);
c999836d Lars-Peter Clausen 2013-04-15  143  	struct dma_chan *(*compat_request_channel)(
c999836d Lars-Peter Clausen 2013-04-15  144  			struct snd_soc_pcm_runtime *rtd,
c999836d Lars-Peter Clausen 2013-04-15  145  			struct snd_pcm_substream *substream);
c999836d Lars-Peter Clausen 2013-04-15  146  	dma_filter_fn compat_filter_fn;
194c7dea Stephen Warren     2013-12-03  147  	struct device *dma_dev;
194c7dea Stephen Warren     2013-12-03  148  	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
28c4468b Lars-Peter Clausen 2013-04-15  149  
28c4468b Lars-Peter Clausen 2013-04-15  150  	const struct snd_pcm_hardware *pcm_hardware;
28c4468b Lars-Peter Clausen 2013-04-15  151  	unsigned int prealloc_buffer_size;
28c4468b Lars-Peter Clausen 2013-04-15 @152  };
28c4468b Lars-Peter Clausen 2013-04-15  153  
28c4468b Lars-Peter Clausen 2013-04-15  154  int snd_dmaengine_pcm_register(struct device *dev,
28c4468b Lars-Peter Clausen 2013-04-15  155  	const struct snd_dmaengine_pcm_config *config,
28c4468b Lars-Peter Clausen 2013-04-15  156  	unsigned int flags);
28c4468b Lars-Peter Clausen 2013-04-15  157  void snd_dmaengine_pcm_unregister(struct device *dev);
28c4468b Lars-Peter Clausen 2013-04-15  158  
21585ee8 Lars-Peter Clausen 2013-11-28  159  int devm_snd_dmaengine_pcm_register(struct device *dev,
21585ee8 Lars-Peter Clausen 2013-11-28  160  	const struct snd_dmaengine_pcm_config *config,

:::::: The code at line 152 was first introduced by commit
:::::: 28c4468b00a1e55e08cc20117de968f7c6275441 ASoC: Add a generic dmaengine_pcm driver

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6425 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/7b032151/attachment.gz>
