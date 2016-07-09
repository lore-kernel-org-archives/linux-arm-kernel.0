From: lkp@intel.com (kbuild test robot)
Date: Sat, 9 Jul 2016 14:13:22 +0800
Subject: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
In-Reply-To: <1468038656-10345-2-git-send-email-rajesh.bhagat@nxp.com>
Message-ID: <201607091415.HCFoOhSA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on phy/next]
[also build test WARNING on v4.7-rc6 next-20160708]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rajesh-Bhagat/drivers-usb-chipidea-Add-qoriq-platform-driver/20160709-130557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: mn10300-allyesconfig (attached as .config)
compiler: am33_2.0-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mn10300 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:289:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/usb/chipidea/ci_hdrc_qoriq.c:12:
   drivers/usb/chipidea/ci_hdrc_qoriq.c: In function 'ci_hdrc_qoriq_usb_setup':
>> include/linux/dynamic_debug.h:64:16: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1197:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/usb/chipidea/ci_hdrc_qoriq.c:85:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
     ^
   include/linux/dynamic_debug.h:64:16: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1197:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/usb/chipidea/ci_hdrc_qoriq.c:85:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
     ^

vim +64 include/linux/dynamic_debug.h

b48420c1 Jim Cromie  2012-04-27  48  					const char *modname);
b48420c1 Jim Cromie  2012-04-27  49  
cbc46635 Joe Perches 2011-08-11  50  struct device;
cbc46635 Joe Perches 2011-08-11  51  
b9075fa9 Joe Perches 2011-10-31  52  extern __printf(3, 4)
906d2015 Joe Perches 2014-09-24  53  void __dynamic_dev_dbg(struct _ddebug *descriptor, const struct device *dev,
b9075fa9 Joe Perches 2011-10-31  54  		       const char *fmt, ...);
cbc46635 Joe Perches 2011-08-11  55  
ffa10cb4 Jason Baron 2011-08-11  56  struct net_device;
ffa10cb4 Jason Baron 2011-08-11  57  
b9075fa9 Joe Perches 2011-10-31  58  extern __printf(3, 4)
906d2015 Joe Perches 2014-09-24  59  void __dynamic_netdev_dbg(struct _ddebug *descriptor,
ffa10cb4 Jason Baron 2011-08-11  60  			  const struct net_device *dev,
b9075fa9 Joe Perches 2011-10-31  61  			  const char *fmt, ...);
ffa10cb4 Jason Baron 2011-08-11  62  
07613b0b Jason Baron 2011-10-04  63  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
c0d2af63 Joe Perches 2012-10-18 @64  	static struct _ddebug  __aligned(8)			\
07613b0b Jason Baron 2011-10-04  65  	__attribute__((section("__verbose"))) name = {		\
07613b0b Jason Baron 2011-10-04  66  		.modname = KBUILD_MODNAME,			\
07613b0b Jason Baron 2011-10-04  67  		.function = __func__,				\
07613b0b Jason Baron 2011-10-04  68  		.filename = __FILE__,				\
07613b0b Jason Baron 2011-10-04  69  		.format = (fmt),				\
07613b0b Jason Baron 2011-10-04  70  		.lineno = __LINE__,				\
07613b0b Jason Baron 2011-10-04  71  		.flags =  _DPRINTK_FLAGS_DEFAULT,		\
07613b0b Jason Baron 2011-10-04  72  	}

:::::: The code at line 64 was first introduced by commit
:::::: c0d2af637863940b1a4fb208224ca7acb905c39f dynamic_debug: Remove unnecessary __used

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 39173 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160709/686a9682/attachment-0001.obj>
