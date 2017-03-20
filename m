From: lkp@intel.com (kbuild test robot)
Date: Mon, 20 Mar 2017 16:04:44 +0800
Subject: [alsa-devel] [PATCH v3 05/11] IIO: ADC: add stm32 DFSDM support
 for Sigma delta ADC
In-Reply-To: <1489759704-30217-6-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201703201606.vtNxTrh2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.11-rc3]
[cannot apply to iio/togreg next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170320-133247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/iio/hw_consumer.c:23:20: error: field 'buffer' has incomplete type
     struct iio_buffer buffer;
                       ^~~~~~
   drivers/iio/hw_consumer.c: In function 'iio_buffer_to_hw_consumer_buffer':
>> drivers/iio/hw_consumer.c:29:79: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     return container_of(buffer, struct hw_consumer_buffer, buffer);
                                                                                  ^
   drivers/iio/hw_consumer.c: At top level:
   drivers/iio/hw_consumer.c:40:21: error: variable 'iio_hw_buf_access' has initializer but incomplete type
    static const struct iio_buffer_access_funcs iio_hw_buf_access = {
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c:41:2: error: unknown field 'release' specified in initializer
     .release = &iio_hw_buf_release,
     ^
   drivers/iio/hw_consumer.c:41:13: warning: excess elements in struct initializer
     .release = &iio_hw_buf_release,
                ^
   drivers/iio/hw_consumer.c:41:13: note: (near initialization for 'iio_hw_buf_access')
   drivers/iio/hw_consumer.c:42:2: error: unknown field 'modes' specified in initializer
     .modes = INDIO_BUFFER_HARDWARE,
     ^
   drivers/iio/hw_consumer.c:42:11: warning: excess elements in struct initializer
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~
   drivers/iio/hw_consumer.c:42:11: note: (near initialization for 'iio_hw_buf_access')
   drivers/iio/hw_consumer.c: In function 'iio_hw_consumer_get_buffer':
   drivers/iio/hw_consumer.c:66:2: error: implicit declaration of function 'iio_buffer_init' [-Werror=implicit-function-declaration]
     iio_buffer_init(&buf->buffer);
     ^~~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c: In function 'iio_hw_consumer_alloc':
   drivers/iio/hw_consumer.c:110:3: error: implicit declaration of function 'iio_buffer_put' [-Werror=implicit-function-declaration]
      iio_buffer_put(&buf->buffer);
      ^~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c: In function 'iio_hw_consumer_enable':
   drivers/iio/hw_consumer.c:135:9: error: implicit declaration of function 'iio_update_buffers' [-Werror=implicit-function-declaration]
      ret = iio_update_buffers(buf->indio_dev, &buf->buffer, NULL);
            ^~~~~~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c: At top level:
   drivers/iio/hw_consumer.c:40:45: error: storage size of 'iio_hw_buf_access' isn't known
    static const struct iio_buffer_access_funcs iio_hw_buf_access = {
                                                ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/iio/buffer/industrialio-buffer-dma.c:17:0:
   include/linux/iio/buffer-dma.h:107:20: error: field 'buffer' has incomplete type
     struct iio_buffer buffer;
                       ^~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_buffer_block_release':
   drivers/iio/buffer/industrialio-buffer-dma.c:104:2: error: implicit declaration of function 'iio_buffer_put' [-Werror=implicit-function-declaration]
     iio_buffer_put(&block->queue->buffer);
     ^~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_buffer_to_queue':
>> drivers/iio/buffer/industrialio-buffer-dma.c:163:81: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     return container_of(buf, struct iio_dma_buffer_queue, buffer);
                                                                                    ^
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_dma_buffer_alloc_block':
   drivers/iio/buffer/industrialio-buffer-dma.c:188:2: error: implicit declaration of function 'iio_buffer_get' [-Werror=implicit-function-declaration]
     iio_buffer_get(&queue->buffer);
     ^~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_dma_buffer_read':
   drivers/iio/buffer/industrialio-buffer-dma.c:489:16: error: dereferencing pointer to incomplete type 'struct iio_buffer'
     if (n < buffer->bytes_per_datum)
                   ^~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_dma_buffer_init':
   drivers/iio/buffer/industrialio-buffer-dma.c:614:2: error: implicit declaration of function 'iio_buffer_init' [-Werror=implicit-function-declaration]
     iio_buffer_init(&queue->buffer);
     ^~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_buffer_to_queue':
   drivers/iio/buffer/industrialio-buffer-dma.c:164:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors
--
   In file included from drivers/iio/buffer/industrialio-buffer-dmaengine.c:17:0:
   include/linux/iio/buffer-dma.h:107:20: error: field 'buffer' has incomplete type
     struct iio_buffer buffer;
                       ^~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function 'iio_buffer_to_dmaengine_buffer':
>> drivers/iio/buffer/industrialio-buffer-dmaengine.c:43:83: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     return container_of(buffer, struct dmaengine_buffer, queue.buffer);
                                                                                      ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: At top level:
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:109:21: error: variable 'iio_dmaengine_buffer_ops' has initializer but incomplete type
    static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:110:2: error: unknown field 'read_first_n' specified in initializer
     .read_first_n = iio_dma_buffer_read,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:110:18: warning: excess elements in struct initializer
     .read_first_n = iio_dma_buffer_read,
                     ^~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:110:18: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:111:2: error: unknown field 'set_bytes_per_datum' specified in initializer
     .set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:111:25: warning: excess elements in struct initializer
     .set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:111:25: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:112:2: error: unknown field 'set_length' specified in initializer
     .set_length = iio_dma_buffer_set_length,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:112:16: warning: excess elements in struct initializer
     .set_length = iio_dma_buffer_set_length,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:112:16: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:113:2: error: unknown field 'request_update' specified in initializer
     .request_update = iio_dma_buffer_request_update,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:113:20: warning: excess elements in struct initializer
     .request_update = iio_dma_buffer_request_update,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:113:20: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:114:2: error: unknown field 'enable' specified in initializer
     .enable = iio_dma_buffer_enable,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:114:12: warning: excess elements in struct initializer
     .enable = iio_dma_buffer_enable,
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:114:12: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:115:2: error: unknown field 'disable' specified in initializer
     .disable = iio_dma_buffer_disable,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:115:13: warning: excess elements in struct initializer
     .disable = iio_dma_buffer_disable,
                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:115:13: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:116:2: error: unknown field 'data_available' specified in initializer
     .data_available = iio_dma_buffer_data_available,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:116:20: warning: excess elements in struct initializer
     .data_available = iio_dma_buffer_data_available,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:116:20: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:117:2: error: unknown field 'release' specified in initializer
     .release = iio_dmaengine_buffer_release,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:117:13: warning: excess elements in struct initializer
     .release = iio_dmaengine_buffer_release,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:117:13: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:119:2: error: unknown field 'modes' specified in initializer
     .modes = INDIO_BUFFER_HARDWARE,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:119:11: warning: excess elements in struct initializer
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:119:11: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:2: error: unknown field 'flags' specified in initializer
     .flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:11: error: 'INDIO_BUFFER_FLAG_FIXED_WATERMARK' undeclared here (not in a function)
     .flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:11: warning: excess elements in struct initializer
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:11: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function 'iio_dmaengine_buffer_free':
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:206:2: error: implicit declaration of function 'iio_buffer_put' [-Werror=implicit-function-declaration]
     iio_buffer_put(buffer);
     ^~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: At top level:
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:109:45: error: storage size of 'iio_dmaengine_buffer_ops' isn't known
    static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
                                                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function 'iio_buffer_to_dmaengine_buffer':
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:44:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors

vim +29 drivers/iio/hw_consumer.c

d5ca88eb Lars-Peter Clausen 2017-03-17  17  	struct iio_channel *channels;
d5ca88eb Lars-Peter Clausen 2017-03-17  18  };
d5ca88eb Lars-Peter Clausen 2017-03-17  19  
d5ca88eb Lars-Peter Clausen 2017-03-17  20  struct hw_consumer_buffer {
d5ca88eb Lars-Peter Clausen 2017-03-17  21  	struct list_head head;
d5ca88eb Lars-Peter Clausen 2017-03-17  22  	struct iio_dev *indio_dev;
d5ca88eb Lars-Peter Clausen 2017-03-17 @23  	struct iio_buffer buffer;
d5ca88eb Lars-Peter Clausen 2017-03-17  24  };
d5ca88eb Lars-Peter Clausen 2017-03-17  25  
d5ca88eb Lars-Peter Clausen 2017-03-17  26  static struct hw_consumer_buffer *iio_buffer_to_hw_consumer_buffer(
d5ca88eb Lars-Peter Clausen 2017-03-17  27  	struct iio_buffer *buffer)
d5ca88eb Lars-Peter Clausen 2017-03-17  28  {
d5ca88eb Lars-Peter Clausen 2017-03-17 @29  	return container_of(buffer, struct hw_consumer_buffer, buffer);
d5ca88eb Lars-Peter Clausen 2017-03-17  30  }
d5ca88eb Lars-Peter Clausen 2017-03-17  31  
d5ca88eb Lars-Peter Clausen 2017-03-17  32  static void iio_hw_buf_release(struct iio_buffer *buffer)

:::::: The code at line 29 was first introduced by commit
:::::: d5ca88ebd75256ba43b57c82dfa9a3cbeb3cacf7 iio: Add hardware consumer support

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58385 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/955c7942/attachment-0001.gz>
