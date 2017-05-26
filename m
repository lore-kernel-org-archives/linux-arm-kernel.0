From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 26 May 2017 22:05:11 +0800
Subject: [xlnx:2017.1_video_ea 11/28]
 drivers/staging//xilinx/hdmi/phy-vphy.c:141:8: error: redefinition of
 'xvphy_get_xvphy'
Message-ID: <201705262208.gQSCkhaw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rohit,

First bad commit (maybe != root cause):

tree:   https://github.com/Xilinx/linux-xlnx 2017.1_video_ea
head:   79a0e60e9f6535e89d9923e3987398318f0ed4e2
commit: 2d6e151e6186db912023243302ba4880b00a8bad [11/28] staging: xilinx: Add xilinx hdmi drivers to staging area
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2d6e151e6186db912023243302ba4880b00a8bad
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmirx.c:38:
   drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_Out32':
>> drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/ia64/include/asm/io.h:75:0,
                    from arch/ia64/include/asm/smp.h:20,
                    from include/linux/smp.h:59,
                    from include/linux/sched.h:34,
                    from include/linux/ratelimit.h:5,
                    from include/linux/device.h:27,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmirx.c:21:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmirx.c:38:
   drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_In32':
>> drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/ia64/include/asm/io.h:75:0,
                    from arch/ia64/include/asm/smp.h:20,
                    from include/linux/smp.h:59,
                    from include/linux/sched.h:34,
                    from include/linux/ratelimit.h:5,
                    from include/linux/device.h:27,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmirx.c:21:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
--
   In file included from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59:0,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xil_io.h: In function 'Xil_Out32':
>> drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/ia64/include/asm/io.h:75:0,
                    from include/linux/io.h:25,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:61,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59:0,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xil_io.h: In function 'Xil_In32':
>> drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/ia64/include/asm/io.h:75:0,
                    from include/linux/io.h:25,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:61,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging//xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
--
   In file included from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging//xilinx/hdmi/phy-vphy.c:47:
   drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_Out32':
>> drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/ia64/include/asm/io.h:75:0,
                    from arch/ia64/include/asm/smp.h:20,
                    from include/linux/smp.h:59,
                    from include/linux/sched.h:34,
                    from arch/ia64/include/asm/delay.h:16,
                    from include/linux/delay.h:14,
                    from drivers/staging//xilinx/hdmi/phy-vphy.c:32:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging//xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging//xilinx/hdmi/phy-vphy.c:47:
   drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_In32':
>> drivers/staging//xilinx/hdmi/phy-xilinx-vphy/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/ia64/include/asm/io.h:75:0,
                    from arch/ia64/include/asm/smp.h:20,
                    from include/linux/smp.h:59,
                    from include/linux/sched.h:34,
                    from arch/ia64/include/asm/delay.h:16,
                    from include/linux/delay.h:14,
                    from drivers/staging//xilinx/hdmi/phy-vphy.c:32:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
   drivers/staging//xilinx/hdmi/phy-vphy.c: At top level:
>> drivers/staging//xilinx/hdmi/phy-vphy.c:141:8: error: redefinition of 'xvphy_get_xvphy'
    XVphy *xvphy_get_xvphy(struct phy *phy)
           ^~~~~~~~~~~~~~~
   In file included from drivers/staging//xilinx/hdmi/phy-vphy.c:47:0:
   drivers/staging//xilinx/hdmi/include/linux/phy/phy-vphy.h:37:22: note: previous definition of 'xvphy_get_xvphy' was here
    static inline XVphy *xvphy_get_xvphy(struct phy *phy)
                         ^~~~~~~~~~~~~~~
>> drivers/staging//xilinx/hdmi/phy-vphy.c:152:6: error: redefinition of 'xvphy_mutex_lock'
    void xvphy_mutex_lock(struct phy *phy)
         ^~~~~~~~~~~~~~~~
   In file included from drivers/staging//xilinx/hdmi/phy-vphy.c:47:0:
   drivers/staging//xilinx/hdmi/include/linux/phy/phy-vphy.h:42:20: note: previous definition of 'xvphy_mutex_lock' was here
    static inline void xvphy_mutex_lock(struct phy *phy) {}
                       ^~~~~~~~~~~~~~~~
>> drivers/staging//xilinx/hdmi/phy-vphy.c:160:6: error: redefinition of 'xvphy_mutex_unlock'
    void xvphy_mutex_unlock(struct phy *phy)
         ^~~~~~~~~~~~~~~~~~
   In file included from drivers/staging//xilinx/hdmi/phy-vphy.c:47:0:
   drivers/staging//xilinx/hdmi/include/linux/phy/phy-vphy.h:43:20: note: previous definition of 'xvphy_mutex_unlock' was here
    static inline void xvphy_mutex_unlock(struct phy *phy) {}
                       ^~~~~~~~~~~~~~~~~~

vim +/xvphy_get_xvphy +141 drivers/staging//xilinx/hdmi/phy-vphy.c

d29f17963 Rohit Consul 2017-05-05   26  //#define DEBUG
d29f17963 Rohit Consul 2017-05-05   27  //#define DEBUG_TRACE
d29f17963 Rohit Consul 2017-05-05   28  
d29f17963 Rohit Consul 2017-05-05   29  //#define DEBUG_MUTEX
d29f17963 Rohit Consul 2017-05-05   30  
d29f17963 Rohit Consul 2017-05-05   31  #include <linux/clk.h>
d29f17963 Rohit Consul 2017-05-05  @32  #include <linux/delay.h>
d29f17963 Rohit Consul 2017-05-05   33  #include <linux/io.h>
d29f17963 Rohit Consul 2017-05-05   34  #include <linux/kernel.h>
d29f17963 Rohit Consul 2017-05-05   35  #include <linux/module.h>
d29f17963 Rohit Consul 2017-05-05   36  #include <linux/of.h>
d29f17963 Rohit Consul 2017-05-05   37  #include <linux/of_platform.h>
d29f17963 Rohit Consul 2017-05-05   38  #include <linux/of_address.h>
d29f17963 Rohit Consul 2017-05-05   39  #include <linux/phy/phy.h>
d29f17963 Rohit Consul 2017-05-05   40  #include <linux/platform_device.h>
d29f17963 Rohit Consul 2017-05-05   41  #include <linux/delay.h>
d29f17963 Rohit Consul 2017-05-05   42  #include <dt-bindings/phy/phy.h>
d29f17963 Rohit Consul 2017-05-05   43  #include <linux/list.h>
d29f17963 Rohit Consul 2017-05-05   44  #include <linux/slab.h>
d29f17963 Rohit Consul 2017-05-05   45  #include <linux/interrupt.h>
d29f17963 Rohit Consul 2017-05-05   46  
d29f17963 Rohit Consul 2017-05-05   47  #include "linux/phy/phy-vphy.h"
d29f17963 Rohit Consul 2017-05-05   48  
d29f17963 Rohit Consul 2017-05-05   49  /* baseline driver includes */
d29f17963 Rohit Consul 2017-05-05   50  #include "phy-xilinx-vphy/xvphy.h"
d29f17963 Rohit Consul 2017-05-05   51  #include "phy-xilinx-vphy/xvphy_i.h"
d29f17963 Rohit Consul 2017-05-05   52  #include "phy-xilinx-vphy/xil_printf.h"
d29f17963 Rohit Consul 2017-05-05   53  #include "phy-xilinx-vphy/xstatus.h"
d29f17963 Rohit Consul 2017-05-05   54  
d29f17963 Rohit Consul 2017-05-05   55  /* common RX/TX */
d29f17963 Rohit Consul 2017-05-05   56  #include "phy-xilinx-vphy/xvidc.h"
d29f17963 Rohit Consul 2017-05-05   57  #include "phy-xilinx-vphy/xvidc_edid.h"
d29f17963 Rohit Consul 2017-05-05   58  
d29f17963 Rohit Consul 2017-05-05   59  #define XVPHY_DRU_REF_CLK_HZ	156250000
d29f17963 Rohit Consul 2017-05-05   60  
d29f17963 Rohit Consul 2017-05-05   61  
d29f17963 Rohit Consul 2017-05-05   62  /* select either trace or printk logging */
d29f17963 Rohit Consul 2017-05-05   63  #ifdef DEBUG_TRACE
d29f17963 Rohit Consul 2017-05-05   64  #define do_hdmi_dbg(format, ...) do { \
d29f17963 Rohit Consul 2017-05-05   65    trace_printk("xlnx-hdmi-vphy: " format, ##__VA_ARGS__); \
d29f17963 Rohit Consul 2017-05-05   66  } while(0)
d29f17963 Rohit Consul 2017-05-05   67  #else
d29f17963 Rohit Consul 2017-05-05   68  #define do_hdmi_dbg(format, ...) do { \
d29f17963 Rohit Consul 2017-05-05   69    printk(KERN_DEBUG "xlnx-hdmi-vphy: " format, ##__VA_ARGS__); \
d29f17963 Rohit Consul 2017-05-05   70  } while(0)
d29f17963 Rohit Consul 2017-05-05   71  #endif
d29f17963 Rohit Consul 2017-05-05   72  
d29f17963 Rohit Consul 2017-05-05   73  /* either enable or disable debugging */
d29f17963 Rohit Consul 2017-05-05   74  #ifdef DEBUG
d29f17963 Rohit Consul 2017-05-05   75  #  define hdmi_dbg(x...) do_hdmi_dbg(x)
d29f17963 Rohit Consul 2017-05-05   76  #else
d29f17963 Rohit Consul 2017-05-05   77  #  define hdmi_dbg(x...)
d29f17963 Rohit Consul 2017-05-05   78  #endif
d29f17963 Rohit Consul 2017-05-05   79  
d29f17963 Rohit Consul 2017-05-05   80  #if (defined(DEBUG_MUTEX) && defined(DEBUG))
d29f17963 Rohit Consul 2017-05-05   81  /* storage for source code line number where mutex was last locked, -1 otherwise */
d29f17963 Rohit Consul 2017-05-05   82  static int hdmi_mutex_line = -1;
d29f17963 Rohit Consul 2017-05-05   83  /* If mutex is locked, print the line number of where it was locked. lock the mutex.
d29f17963 Rohit Consul 2017-05-05   84   * Please keep this macro on a single line, so that the C __LINE__ macro is correct.
d29f17963 Rohit Consul 2017-05-05   85   */
d29f17963 Rohit Consul 2017-05-05   86  #  define hdmi_mutex_lock(x) do { if (mutex_is_locked(x)) { hdmi_dbg("@line %d waiting for mutex owner @line %d\n", __LINE__, hdmi_mutex_line); } mutex_lock(x); hdmi_mutex_line = __LINE__; } while(0)
d29f17963 Rohit Consul 2017-05-05   87  #  define hdmi_mutex_unlock(x) do { hdmi_mutex_line = -1; mutex_unlock(x); } while(0)
d29f17963 Rohit Consul 2017-05-05   88  /* non-debug variant */
d29f17963 Rohit Consul 2017-05-05   89  #else
d29f17963 Rohit Consul 2017-05-05   90  #  define hdmi_mutex_lock(x) mutex_lock(x)
d29f17963 Rohit Consul 2017-05-05   91  #  define hdmi_mutex_unlock(x) mutex_unlock(x)
d29f17963 Rohit Consul 2017-05-05   92  #endif
d29f17963 Rohit Consul 2017-05-05   93  
d29f17963 Rohit Consul 2017-05-05   94  /**
d29f17963 Rohit Consul 2017-05-05   95   * struct xvphy_lane - representation of a lane
d29f17963 Rohit Consul 2017-05-05   96   * @phy: pointer to the kernel PHY device
d29f17963 Rohit Consul 2017-05-05   97   *
d29f17963 Rohit Consul 2017-05-05   98   * @type: controller which uses this lane
d29f17963 Rohit Consul 2017-05-05   99   * @lane: lane number
d29f17963 Rohit Consul 2017-05-05  100   * @protocol: protocol in which the lane operates
d29f17963 Rohit Consul 2017-05-05  101   * @ref_clk: enum of allowed ref clock rates for this lane PLL
d29f17963 Rohit Consul 2017-05-05  102   * @pll_lock: PLL status
d29f17963 Rohit Consul 2017-05-05  103   * @data: pointer to hold private data
d29f17963 Rohit Consul 2017-05-05  104   * @direction: 0=rx, 1=tx
d29f17963 Rohit Consul 2017-05-05  105   * @share_laneclk: lane number of the clock to be shared
d29f17963 Rohit Consul 2017-05-05  106   */
d29f17963 Rohit Consul 2017-05-05  107  struct xvphy_lane {
d29f17963 Rohit Consul 2017-05-05  108  	struct phy *phy;
d29f17963 Rohit Consul 2017-05-05  109  	u8 type;
d29f17963 Rohit Consul 2017-05-05  110  	u8 lane;
d29f17963 Rohit Consul 2017-05-05  111  	u8 protocol;
d29f17963 Rohit Consul 2017-05-05  112  	bool pll_lock;
d29f17963 Rohit Consul 2017-05-05  113  	/* data is pointer to parent xvphy_dev */
d29f17963 Rohit Consul 2017-05-05  114  	void *data;
d29f17963 Rohit Consul 2017-05-05  115  	bool direction_tx;
d29f17963 Rohit Consul 2017-05-05  116  	u32 share_laneclk;
d29f17963 Rohit Consul 2017-05-05  117  };
d29f17963 Rohit Consul 2017-05-05  118  
d29f17963 Rohit Consul 2017-05-05  119  /**
d29f17963 Rohit Consul 2017-05-05  120   * struct xvphy_dev - representation of a Xilinx Video PHY
d29f17963 Rohit Consul 2017-05-05  121   * @dev: pointer to device
d29f17963 Rohit Consul 2017-05-05  122   * @iomem: serdes base address
d29f17963 Rohit Consul 2017-05-05  123   */
d29f17963 Rohit Consul 2017-05-05  124  struct xvphy_dev {
d29f17963 Rohit Consul 2017-05-05  125  	struct device *dev;
d29f17963 Rohit Consul 2017-05-05  126  	/* virtual remapped I/O memory */
d29f17963 Rohit Consul 2017-05-05  127  	void __iomem *iomem;
d29f17963 Rohit Consul 2017-05-05  128  	int irq;
d29f17963 Rohit Consul 2017-05-05  129  	/* protects the XVphy baseline against concurrent access */
d29f17963 Rohit Consul 2017-05-05  130  	struct mutex xvphy_mutex;
d29f17963 Rohit Consul 2017-05-05  131  	struct xvphy_lane *lanes[4];
d29f17963 Rohit Consul 2017-05-05  132  	/* bookkeeping for the baseline subsystem driver instance */
d29f17963 Rohit Consul 2017-05-05  133  	XVphy xvphy;
d29f17963 Rohit Consul 2017-05-05  134  	/* AXI Lite clock drives the clock detector */
d29f17963 Rohit Consul 2017-05-05  135  	struct clk *axi_lite_clk;
d29f17963 Rohit Consul 2017-05-05  136  	/* NI-DRU clock input */
d29f17963 Rohit Consul 2017-05-05  137  	struct clk *clkp;
d29f17963 Rohit Consul 2017-05-05  138  };
d29f17963 Rohit Consul 2017-05-05  139  
d29f17963 Rohit Consul 2017-05-05  140  /* given the (Linux) phy handle, return the xvphy */
d29f17963 Rohit Consul 2017-05-05 @141  XVphy *xvphy_get_xvphy(struct phy *phy)
d29f17963 Rohit Consul 2017-05-05  142  {
d29f17963 Rohit Consul 2017-05-05  143  	struct xvphy_lane *vphy_lane = phy_get_drvdata(phy);
d29f17963 Rohit Consul 2017-05-05  144  	struct xvphy_dev *vphy_dev = vphy_lane->data;
d29f17963 Rohit Consul 2017-05-05  145  	return &vphy_dev->xvphy;
d29f17963 Rohit Consul 2017-05-05  146  }
d29f17963 Rohit Consul 2017-05-05  147  EXPORT_SYMBOL_GPL(xvphy_get_xvphy);
d29f17963 Rohit Consul 2017-05-05  148  
d29f17963 Rohit Consul 2017-05-05  149  /* given the (Linux) phy handle, enter critical section of xvphy baseline code
d29f17963 Rohit Consul 2017-05-05  150   * XVphy functions must be called with mutex acquired to prevent concurrent access
d29f17963 Rohit Consul 2017-05-05  151   * by XVphy and upper-layer video protocol drivers */
d29f17963 Rohit Consul 2017-05-05 @152  void xvphy_mutex_lock(struct phy *phy)
d29f17963 Rohit Consul 2017-05-05  153  {
d29f17963 Rohit Consul 2017-05-05  154  	struct xvphy_lane *vphy_lane = phy_get_drvdata(phy);
d29f17963 Rohit Consul 2017-05-05  155  	struct xvphy_dev *vphy_dev = vphy_lane->data;
d29f17963 Rohit Consul 2017-05-05  156  	hdmi_mutex_lock(&vphy_dev->xvphy_mutex);
d29f17963 Rohit Consul 2017-05-05  157  }
d29f17963 Rohit Consul 2017-05-05  158  EXPORT_SYMBOL_GPL(xvphy_mutex_lock);
d29f17963 Rohit Consul 2017-05-05  159  
d29f17963 Rohit Consul 2017-05-05 @160  void xvphy_mutex_unlock(struct phy *phy)
d29f17963 Rohit Consul 2017-05-05  161  {
d29f17963 Rohit Consul 2017-05-05  162  	struct xvphy_lane *vphy_lane = phy_get_drvdata(phy);
d29f17963 Rohit Consul 2017-05-05  163  	struct xvphy_dev *vphy_dev = vphy_lane->data;

:::::: The code at line 141 was first introduced by commit
:::::: d29f179637587571617a4734c29cdf32bdb8e767 phy: xilinx-vphy: Initial release of xilinx video phy soft IP driver

:::::: TO: Rohit Consul <rohitco@xilinx.com>
:::::: CC: Jeffrey Mouroux <jmouroux@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45286 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170526/793d1c82/attachment-0001.gz>
