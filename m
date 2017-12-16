From: lkp@intel.com (kbuild test robot)
Date: Sat, 16 Dec 2017 12:06:18 +0800
Subject: [PATCH] drm: Fix possible deadlock in drm_mode_config_cleanup()
In-Reply-To: <20171213085720.6059-1-m.szyprowski@samsung.com>
References: <20171213085720.6059-1-m.szyprowski@samsung.com>
Message-ID: <201712161156.ZrlDcGKV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.15-rc3]
[cannot apply to drm/drm-next drm-exynos/exynos-drm/for-next drm-intel/for-linux-next next-20171215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marek-Szyprowski/drm-Fix-possible-deadlock-in-drm_mode_config_cleanup/20171216-102239
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   include/net/cfg80211.h:3278: warning: Excess enum value 'WIPHY_FLAG_SUPPORTS_SCHED_SCAN' description in 'wiphy_flags'
   kernel/sched/core.c:5113: warning: No description found for parameter 't'
   kernel/sched/core.c:5113: warning: Excess function parameter 'interval' description in 'sched_rr_get_interval'
   drivers/gpio/gpiolib.c:601: warning: No description found for parameter '16'
   drivers/gpio/gpiolib.c:601: warning: Excess struct member 'events' description in 'lineevent_state'
   include/linux/iio/iio.h:610: warning: No description found for parameter 'iio_dev'
   include/linux/iio/iio.h:610: warning: Excess function parameter 'indio_dev' description in 'iio_device_register'
   include/linux/iio/trigger.h:79: warning: No description found for parameter 'owner'
   fs/inode.c:1680: warning: No description found for parameter 'rcu'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_transaction'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_next_transaction'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_list'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_vfs_inode'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_flags'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_rsv_handle'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_reserved'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_type'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_line_no'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_start_jiffies'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_requested_credits'
   include/linux/jbd2.h:497: warning: No description found for parameter 'saved_alloc_context'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chkpt_bhs'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_devname'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_average_commit_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_min_batch_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_max_batch_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_commit_callback'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_failed_commit'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chksum_driver'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_csum_seed'
   fs/jbd2/transaction.c:511: warning: No description found for parameter 'type'
   fs/jbd2/transaction.c:511: warning: No description found for parameter 'line_no'
   fs/jbd2/transaction.c:641: warning: No description found for parameter 'gfp_mask'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_mode_config.h:778: warning: No description found for parameter 'connector_free_works'
   include/drm/drm_mode_config.h:778: warning: No description found for parameter 'connector_free_queue'
   include/drm/drm_mode_config.h:778: warning: No description found for parameter 'modifiers_property'
>> include/drm/drm_mode_config.h:778: warning: Excess struct member 'pending_connector_free_works' description in 'drm_mode_config'
>> include/drm/drm_mode_config.h:778: warning: Excess struct member 'pending_connector_free_queue' description in 'drm_mode_config'
   include/drm/drm_mode_config.h:778: warning: Excess struct member 'modifiers' description in 'drm_mode_config'
   include/drm/drm_plane.h:552: warning: No description found for parameter 'modifiers'
   include/drm/drm_plane.h:552: warning: No description found for parameter 'modifier_count'
   drivers/gpu/drm/drm_edid.c:4837: warning: No description found for parameter 'is_hdmi2_sink'
   drivers/gpu/drm/drm_syncobj.c:306: warning: No description found for parameter 'file_private'
   drivers/gpu/drm/drm_syncobj.c:306: warning: No description found for parameter 'syncobj'
   drivers/gpu/drm/drm_syncobj.c:306: warning: No description found for parameter 'handle'
   drivers/gpu/drm/drm_syncobj.c:307: warning: No description found for parameter 'file_private'
   drivers/gpu/drm/drm_syncobj.c:307: warning: No description found for parameter 'syncobj'
   drivers/gpu/drm/drm_syncobj.c:307: warning: No description found for parameter 'handle'
   drivers/gpu/drm/i915/i915_gem.c:548: warning: No description found for parameter 'rps_client'
   drivers/gpu/drm/i915/i915_gem.c:548: warning: Excess function parameter 'rps' description in 'i915_gem_object_wait'
   Error: Cannot open file drivers/gpu/drm/i915/intel_guc_loader.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -function GuC-specific firmware loader drivers/gpu/drm/i915/intel_guc_loader.c' failed with return code 1
   Error: Cannot open file drivers/gpu/drm/i915/intel_guc_loader.c
   Error: Cannot open file drivers/gpu/drm/i915/intel_guc_loader.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -internal drivers/gpu/drm/i915/intel_guc_loader.c' failed with return code 2
   drivers/gpu/host1x/bus.c:50: warning: No description found for parameter 'driver'
   drivers/gpu/drm/tve200/tve200_drv.c:1: warning: no structured comments found
   net/core/dev.c:1678: warning: Excess function parameter 'dev' description in 'call_netdevice_notifiers_info'
   net/core/dev.c:6361: warning: No description found for parameter 'extack'
   net/core/dev.c:6384: warning: No description found for parameter 'extack'
   include/linux/rcupdate.h:571: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:575: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:579: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:581: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:581: WARNING: Inline literal start-string without end-string.
   kernel/time/timer.c:1253: ERROR: Unexpected indentation.
   kernel/time/timer.c:1255: ERROR: Unexpected indentation.
   kernel/time/timer.c:1256: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:989: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:325: WARNING: Inline literal start-string without end-string.
   include/linux/iio/iio.h:219: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:220: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:226: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/ata/libata-core.c:5913: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5051: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1899: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/regulator/driver.h:271: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   include/linux/spi/spi.h:373: ERROR: Unexpected indentation.
   drivers/w1/w1_io.c:197: WARNING: Definition list ends without a blank line; unexpected unindent.
   net/core/dev.c:4483: ERROR: Unknown target name: "page_is".
   Documentation/trace/ftrace-uses.rst:53: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/trace/ftrace-uses.rst:89: WARNING: Inline emphasis start-string without end-string.
   Documentation/trace/ftrace-uses.rst:89: WARNING: Inline emphasis start-string without end-string.
   Documentation/errseq.rst:: WARNING: document isn't included in any toctree
   Documentation/networking/msg_zerocopy.rst:: WARNING: document isn't included in any toctree
   Documentation/trace/ftrace-uses.rst:: WARNING: document isn't included in any toctree
   Documentation/virtual/kvm/vcpu-requests.rst:: WARNING: document isn't included in any toctree
   Documentation/dev-tools/kselftest.rst:15: WARNING: Could not lex literal_block as "c". Highlighting skipped.
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 133: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 164: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 193: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 133: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 164: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 193: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 133: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 164: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 193: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 133: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 164: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 193: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected

vim +778 include/drm/drm_mode_config.h

28575f16 Daniel Vetter 2016-11-14 @778  

:::::: The code at line 778 was first introduced by commit
:::::: 28575f165d36051310d7ea2350e2011f8095b6fb drm: Extract drm_mode_config.[hc]

:::::: TO: Daniel Vetter <daniel.vetter@ffwll.ch>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6843 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171216/5ccb7fc1/attachment-0001.gz>
