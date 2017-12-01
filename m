From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Dec 2017 23:12:33 +0800
Subject: [alsa-devel] [PATCH v5 04/13] IIO: inkern: API for manipulating
 channel attributes
In-Reply-To: <1511881557-28596-5-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-5-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201712012237.LTTWmzPq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.15-rc1 next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20171201-215409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-randconfig-x012-201748 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/envelope-detector.c:38:0:
>> include/linux/iio/consumer.h:228:20: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
        int val2, enum iio_chan_info_enum attribute);
                       ^~~~~~~~~~~~~~~~~~
   include/linux/iio/consumer.h:242:27: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
              int *val2, enum iio_chan_info_enum attribute);
                              ^~~~~~~~~~~~~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 include/linux/kernel.h:kstrtoul
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock_irq
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irq
   Cyclomatic Complexity 1 include/linux/completion.h:__init_completion
   Cyclomatic Complexity 1 include/linux/jiffies.h:_msecs_to_jiffies
   Cyclomatic Complexity 3 include/linux/jiffies.h:msecs_to_jiffies
   Cyclomatic Complexity 1 include/linux/workqueue.h:queue_delayed_work
   Cyclomatic Complexity 1 include/linux/workqueue.h:schedule_delayed_work
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_priv
   Cyclomatic Complexity 1 include/linux/irq.h:irqd_get_trigger_type
   Cyclomatic Complexity 2 include/linux/irq.h:irq_get_trigger_type
   Cyclomatic Complexity 1 include/linux/interrupt.h:devm_request_irq
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_set_drvdata
   Cyclomatic Complexity 1 drivers/iio/adc/envelope-detector.c:envelope_detector_driver_init
   Cyclomatic Complexity 15 drivers/iio/adc/envelope-detector.c:envelope_detector_probe
   Cyclomatic Complexity 1 drivers/iio/adc/envelope-detector.c:envelope_detector_comp_isr
   Cyclomatic Complexity 3 drivers/iio/adc/envelope-detector.c:envelope_store_comp_interval
   Cyclomatic Complexity 1 drivers/iio/adc/envelope-detector.c:envelope_show_comp_interval
   Cyclomatic Complexity 1 drivers/iio/adc/envelope-detector.c:envelope_show_invert
   Cyclomatic Complexity 6 drivers/iio/adc/envelope-detector.c:envelope_store_invert
   Cyclomatic Complexity 3 drivers/iio/adc/envelope-detector.c:envelope_detector_comp_latch
   Cyclomatic Complexity 5 drivers/iio/adc/envelope-detector.c:envelope_detector_setup_compare
   Cyclomatic Complexity 5 drivers/iio/adc/envelope-detector.c:envelope_detector_read_raw
   Cyclomatic Complexity 3 drivers/iio/adc/envelope-detector.c:envelope_detector_timeout
   Cyclomatic Complexity 1 drivers/iio/adc/envelope-detector.c:envelope_detector_driver_exit
--
   In file included from drivers/iio/multiplexer/iio-mux.c:14:0:
>> include/linux/iio/consumer.h:228:20: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
        int val2, enum iio_chan_info_enum attribute);
                       ^~~~~~~~~~~~~~~~~~
   include/linux/iio/consumer.h:242:27: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
              int *val2, enum iio_chan_info_enum attribute);
                              ^~~~~~~~~~~~~~~~~~
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 1 include/linux/device.h:devm_kzalloc
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_channel_has_info
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_channel_has_available
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_priv
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_set_drvdata
   Cyclomatic Complexity 1 drivers/iio/multiplexer/iio-mux.c:mux_driver_init
   Cyclomatic Complexity 7 drivers/iio/multiplexer/iio-mux.c:iio_mux_select
   Cyclomatic Complexity 1 drivers/iio/multiplexer/iio-mux.c:iio_mux_deselect
   Cyclomatic Complexity 5 drivers/iio/multiplexer/iio-mux.c:mux_write_ext_info
   Cyclomatic Complexity 2 drivers/iio/multiplexer/iio-mux.c:mux_read_ext_info
   Cyclomatic Complexity 3 drivers/iio/multiplexer/iio-mux.c:mux_write_raw
   Cyclomatic Complexity 3 drivers/iio/multiplexer/iio-mux.c:mux_read_avail
   Cyclomatic Complexity 4 drivers/iio/multiplexer/iio-mux.c:mux_read_raw
   Cyclomatic Complexity 16 drivers/iio/multiplexer/iio-mux.c:mux_configure_channel
   Cyclomatic Complexity 20 drivers/iio/multiplexer/iio-mux.c:mux_probe
   Cyclomatic Complexity 1 drivers/iio/multiplexer/iio-mux.c:mux_driver_exit
--
   In file included from drivers/iio//adc/envelope-detector.c:38:0:
>> include/linux/iio/consumer.h:228:20: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
        int val2, enum iio_chan_info_enum attribute);
                       ^~~~~~~~~~~~~~~~~~
   include/linux/iio/consumer.h:242:27: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
              int *val2, enum iio_chan_info_enum attribute);
                              ^~~~~~~~~~~~~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 include/linux/kernel.h:kstrtoul
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock_irq
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irq
   Cyclomatic Complexity 1 include/linux/completion.h:__init_completion
   Cyclomatic Complexity 1 include/linux/jiffies.h:_msecs_to_jiffies
   Cyclomatic Complexity 3 include/linux/jiffies.h:msecs_to_jiffies
   Cyclomatic Complexity 1 include/linux/workqueue.h:queue_delayed_work
   Cyclomatic Complexity 1 include/linux/workqueue.h:schedule_delayed_work
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_priv
   Cyclomatic Complexity 1 include/linux/irq.h:irqd_get_trigger_type
   Cyclomatic Complexity 2 include/linux/irq.h:irq_get_trigger_type
   Cyclomatic Complexity 1 include/linux/interrupt.h:devm_request_irq
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_set_drvdata
   Cyclomatic Complexity 1 drivers/iio//adc/envelope-detector.c:envelope_detector_driver_init
   Cyclomatic Complexity 15 drivers/iio//adc/envelope-detector.c:envelope_detector_probe
   Cyclomatic Complexity 1 drivers/iio//adc/envelope-detector.c:envelope_detector_comp_isr
   Cyclomatic Complexity 3 drivers/iio//adc/envelope-detector.c:envelope_store_comp_interval
   Cyclomatic Complexity 1 drivers/iio//adc/envelope-detector.c:envelope_show_comp_interval
   Cyclomatic Complexity 1 drivers/iio//adc/envelope-detector.c:envelope_show_invert
   Cyclomatic Complexity 6 drivers/iio//adc/envelope-detector.c:envelope_store_invert
   Cyclomatic Complexity 3 drivers/iio//adc/envelope-detector.c:envelope_detector_comp_latch
   Cyclomatic Complexity 5 drivers/iio//adc/envelope-detector.c:envelope_detector_setup_compare
   Cyclomatic Complexity 5 drivers/iio//adc/envelope-detector.c:envelope_detector_read_raw
   Cyclomatic Complexity 3 drivers/iio//adc/envelope-detector.c:envelope_detector_timeout
   Cyclomatic Complexity 1 drivers/iio//adc/envelope-detector.c:envelope_detector_driver_exit
--
   In file included from drivers/iio//multiplexer/iio-mux.c:14:0:
>> include/linux/iio/consumer.h:228:20: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
        int val2, enum iio_chan_info_enum attribute);
                       ^~~~~~~~~~~~~~~~~~
   include/linux/iio/consumer.h:242:27: warning: 'enum iio_chan_info_enum' declared inside parameter list will not be visible outside of this definition or declaration
              int *val2, enum iio_chan_info_enum attribute);
                              ^~~~~~~~~~~~~~~~~~
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 1 include/linux/device.h:devm_kzalloc
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_channel_has_info
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_channel_has_available
   Cyclomatic Complexity 1 include/linux/iio/iio.h:iio_priv
   Cyclomatic Complexity 1 include/linux/platform_device.h:platform_set_drvdata
   Cyclomatic Complexity 1 drivers/iio//multiplexer/iio-mux.c:mux_driver_init
   Cyclomatic Complexity 7 drivers/iio//multiplexer/iio-mux.c:iio_mux_select
   Cyclomatic Complexity 1 drivers/iio//multiplexer/iio-mux.c:iio_mux_deselect
   Cyclomatic Complexity 5 drivers/iio//multiplexer/iio-mux.c:mux_write_ext_info
   Cyclomatic Complexity 2 drivers/iio//multiplexer/iio-mux.c:mux_read_ext_info
   Cyclomatic Complexity 3 drivers/iio//multiplexer/iio-mux.c:mux_write_raw
   Cyclomatic Complexity 3 drivers/iio//multiplexer/iio-mux.c:mux_read_avail
   Cyclomatic Complexity 4 drivers/iio//multiplexer/iio-mux.c:mux_read_raw
   Cyclomatic Complexity 16 drivers/iio//multiplexer/iio-mux.c:mux_configure_channel
   Cyclomatic Complexity 20 drivers/iio//multiplexer/iio-mux.c:mux_probe
   Cyclomatic Complexity 1 drivers/iio//multiplexer/iio-mux.c:mux_driver_exit

vim +228 include/linux/iio/consumer.h

   217	
   218	/**
   219	 * iio_write_channel_attribute() - Write values to the device attribute.
   220	 * @chan:	The channel being queried.
   221	 * @val:	Value being written.
   222	 * @val2:	Value being written.val2 use depends on attribute type.
   223	 * @attribute:	info attribute to be read.
   224	 *
   225	 * Returns an error code or 0.
   226	 */
   227	int iio_write_channel_attribute(struct iio_channel *chan, int val,
 > 228					int val2, enum iio_chan_info_enum attribute);
   229	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28248 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/552f1dc2/attachment-0001.gz>
