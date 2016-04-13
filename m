From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Apr 2016 19:29:02 +0800
Subject: [PATCH 1/2] [media] atmel-isc: add the Image Sensor Controller
 code
In-Reply-To: <1460533460-32336-2-git-send-email-songjun.wu@atmel.com>
Message-ID: <201604131955.rdR7pXLK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Songjun,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.6-rc3 next-20160413]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Songjun-Wu/atmel-isc-add-driver-for-Atmel-ISC/20160413-155337
base:   git://linuxtv.org/media_tree.git master
config: sparc64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All error/warnings (new ones prefixed by >>):

>> drivers/media/platform/atmel/atmel-isc.c:67:18: error: field 'hw' has incomplete type
     struct clk_hw   hw;
                     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from drivers/media/platform/atmel/atmel-isc.c:27:
   drivers/media/platform/atmel/atmel-isc.c: In function 'isc_clk_enable':
   include/linux/kernel.h:824:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
>> drivers/media/platform/atmel/atmel-isc.c:247:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   include/linux/kernel.h:824:48: warning: (near initialization for 'isc_clk')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
>> drivers/media/platform/atmel/atmel-isc.c:247:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   drivers/media/platform/atmel/atmel-isc.c: In function 'isc_clk_disable':
   include/linux/kernel.h:824:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
   drivers/media/platform/atmel/atmel-isc.c:280:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   include/linux/kernel.h:824:48: warning: (near initialization for 'isc_clk')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
   drivers/media/platform/atmel/atmel-isc.c:280:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   drivers/media/platform/atmel/atmel-isc.c: In function 'isc_clk_is_enabled':
   include/linux/kernel.h:824:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
   drivers/media/platform/atmel/atmel-isc.c:295:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   include/linux/kernel.h:824:48: warning: (near initialization for 'isc_clk')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
   drivers/media/platform/atmel/atmel-isc.c:295:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   drivers/media/platform/atmel/atmel-isc.c: In function 'isc_clk_recalc_rate':
   include/linux/kernel.h:824:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
   drivers/media/platform/atmel/atmel-isc.c:309:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   include/linux/kernel.h:824:48: warning: (near initialization for 'isc_clk')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/media/platform/atmel/atmel-isc.c:55:24: note: in expansion of macro 'container_of'
    #define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
                           ^
   drivers/media/platform/atmel/atmel-isc.c:309:28: note: in expansion of macro 'to_isc_clk'
     struct isc_clk *isc_clk = to_isc_clk(hw);
                               ^
   drivers/media/platform/atmel/atmel-isc.c: At top level:
>> drivers/media/platform/atmel/atmel-isc.c:315:14: warning: 'struct clk_rate_request' declared inside parameter list
          struct clk_rate_request *req)
                 ^
>> drivers/media/platform/atmel/atmel-isc.c:315:14: warning: its scope is only this definition or declaration, which is probably not what you want
   drivers/media/platform/atmel/atmel-isc.c: In function 'isc_clk_determine_rate':
>> drivers/media/platform/atmel/atmel-isc.c:324:2: error: implicit declaration of function 'clk_hw_get_num_parents' [-Werror=implicit-function-declaration]
     for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
     ^
>> drivers/media/platform/atmel/atmel-isc.c:325:3: error: implicit declaration of function 'clk_hw_get_parent_by_index' [-Werror=implicit-function-declaration]
      parent = clk_hw_get_parent_by_index(hw, i);
      ^
>> drivers/media/platform/atmel/atmel-isc.c:325:10: warning: assignment makes pointer from integer without a cast
      parent = clk_hw_get_parent_by_index(hw, i);
             ^
>> drivers/media/platform/atmel/atmel-isc.c:329:3: error: implicit declaration of function 'clk_hw_get_rate' [-Werror=implicit-function-declaration]
      parent_rate = clk_hw_get_rate(parent);
      ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from drivers/media/platform/atmel/atmel-isc.c:27:
>> drivers/media/platform/atmel/atmel-isc.c:335:22: error: dereferencing pointer to incomplete type
       tmp_diff = abs(req->rate - tmp_rate);
                         ^
   include/linux/kernel.h:222:38: note: in definition of macro '__abs_choose_expr'
     __builtin_types_compatible_p(typeof(x),   signed type) || \
                                         ^
>> drivers/media/platform/atmel/atmel-isc.c:335:15: note: in expansion of macro 'abs'
       tmp_diff = abs(req->rate - tmp_rate);
                  ^
>> drivers/media/platform/atmel/atmel-isc.c:335:22: error: dereferencing pointer to incomplete type
       tmp_diff = abs(req->rate - tmp_rate);
                         ^
   include/linux/kernel.h:223:38: note: in definition of macro '__abs_choose_expr'
     __builtin_types_compatible_p(typeof(x), unsigned type),  \
                                         ^

vim +/hw +67 drivers/media/platform/atmel/atmel-isc.c

    21	 * CBC: Contrast and Brightness control
    22	 * SUB: This module performs YCbCr444 to YCbCr420 chrominance subsampling
    23	 * RLP: This module performs rounding, range limiting
    24	 *      and packing of the incoming data
    25	 */
    26	
  > 27	#include <linux/of.h>
    28	#include <linux/clk.h>
    29	#include <linux/clkdev.h>
    30	#include <linux/clk-provider.h>
    31	#include <linux/interrupt.h>
    32	#include <linux/module.h>
    33	#include <linux/platform_device.h>
    34	#include <linux/regmap.h>
    35	#include <linux/delay.h>
    36	#include <linux/videodev2.h>
    37	
    38	#include <media/v4l2-device.h>
    39	#include <media/v4l2-ioctl.h>
    40	#include <media/v4l2-of.h>
    41	#include <media/videobuf2-dma-contig.h>
    42	
    43	#include "atmel-isc-regs.h"
    44	
    45	#define ATMEL_ISC_NAME	  "atmel_isc"
    46	
    47	#define ISC_MAX_BUF_NUM		VIDEO_MAX_FRAME
    48	#define ISC_MAX_SUPPORT_WIDTH   2592
    49	#define ISC_MAX_SUPPORT_HEIGHT  1944
    50	
    51	#define ISC_ISPCK_SOURCE_MAX    2
    52	#define ISC_MCK_SOURCE_MAX      3
    53	#define ISC_CLK_MAX_DIV		255
    54	
  > 55	#define to_isc_clk(hw) container_of(hw, struct isc_clk, hw)
    56	
    57	static u32 sensor_preferred;
    58	
    59	static DEFINE_SPINLOCK(isc_clk_lock);
    60	
    61	enum isc_clk_id {
    62		ISC_ISPCK = 0,
    63		ISC_MCK = 1,
    64	};
    65	
    66	struct isc_clk {
  > 67		struct clk_hw   hw;
    68		struct clk      *clk;
    69		struct regmap   *regmap;
    70		spinlock_t      *lock;
    71		enum isc_clk_id id;
    72		u32		div;
    73		u8		parent_id;
    74	};
    75	
    76	struct isc_buffer {
    77		struct vb2_v4l2_buffer  vb;
    78		struct list_head	list;
    79	};
    80	
    81	struct isc_subdev_entity {
    82		struct v4l2_subdev		*sd;
    83		struct v4l2_async_subdev	*asd;
    84		struct v4l2_async_notifier      notifier;
    85	
    86		u32 hsync_active;
    87		u32 vsync_active;
    88		u32 pclk_sample;
    89	
    90		struct list_head list;
    91	};
    92	
    93	/*
    94	 * struct isc_format - ISC media bus format information
    95	 * @fourcc:		Fourcc code for this format
    96	 * @isc_mbus_code:      V4L2 media bus format code if ISC is preferred
    97	 * @sd_mbus_code:       V4L2 media bus format code if subdev is preferred
    98	 * @bpp:		Bytes per pixel (when stored in memory)
    99	 * @reg_sd_bps:		reg value for bits per sample if subdev is preferred
   100	 *			(when transferred over a bus)
   101	 * @reg_isc_bps:	reg value for bits per sample if ISC is preferred
   102	 *			(when transferred over a bus)
   103	 * @pipeline:		pipeline switch if ISC is preferred
   104	 * @isc_support:	ISC can convert raw format to this format
   105	 * @sd_support:		Subdev supports this format
   106	 */
   107	struct isc_format {
   108		u32	fourcc;
   109		u32	isc_mbus_code;
   110		u32	sd_mbus_code;
   111	
   112		u8	bpp;
   113	
   114		u32	reg_sd_bps;
   115		u32	reg_isc_bps;
   116	
   117		u32	reg_wb_cfg;
   118		u32	reg_cfa_cfg;
   119		u32	reg_rlp_mode;
   120		u32	reg_dcfg_imode;
   121		u32	reg_dctrl_dview;
   122	
   123		u32	pipeline;
   124	
   125		bool	isc_support;
   126		bool	sd_support;
   127	};
   128	
   129	struct isc_device {
   130		struct regmap		*regmap;
   131		struct clk		*hclock;
   132		struct clk		*ispck;
   133		struct isc_clk		isc_clks[2];
   134	
   135		struct device		*dev;
   136		struct v4l2_device	v4l2_dev;
   137		struct video_device	video_dev;
   138	
   139		struct vb2_queue	vb2_vidq;
   140		struct vb2_alloc_ctx	*alloc_ctx;
   141	
   142		spinlock_t		dma_queue_lock;
   143		struct list_head	dma_queue;
   144		struct isc_buffer	*cur_frm;
   145		unsigned int		sequence;
   146		bool			stop;
   147	
   148		struct v4l2_format	fmt;
   149	
   150		struct isc_format	**user_formats;
   151		int			num_user_formats;
   152		const struct isc_format	*current_fmt;
   153	
   154		struct mutex		lock;
   155	
   156		struct isc_subdev_entity	*current_subdev;
   157		struct list_head		subdev_entities;
   158	};
   159	
   160	struct reg_mask {
   161		u32 reg;
   162		u32 mask;
   163	};
   164	
   165	/* WB-->CFA-->CC-->GAM-->CSC-->CBC-->SUB422-->SUB420 */
   166	const struct reg_mask pipeline_regs[] = {
   167		{ ISC_WB_CTRL,  ISC_WB_CTRL_MASK },
   168		{ ISC_CFA_CTRL, ISC_CFA_CTRL_MASK },
   169		{ ISC_CC_CTRL,  ISC_CC_CTRL_MASK },
   170		{ ISC_GAM_CTRL, ISC_GAM_CTRL_MASK | ISC_GAM_CTRL_ALL_CHAN_MASK },
   171		{ ISC_CSC_CTRL, ISC_CSC_CTRL_MASK },
   172		{ ISC_CBC_CTRL, ISC_CBC_CTRL_MASK },
   173		{ ISC_SUB422_CTRL, ISC_SUB422_CTRL_MASK },
   174		{ ISC_SUB420_CTRL, ISC_SUB420_CTRL_MASK }
   175	};
   176	
   177	#define RAW_FMT_INDEX_START	0
   178	#define RAW_FMT_INDEX_END	11
   179	#define ISC_FMT_INDEX_START	12
   180	#define ISC_FMT_INDEX_END	12
   181	
   182	/*
   183	 * index(0~11):  raw formats.
   184	 * index(12~12): the formats which can be converted from raw format by ISC.
   185	 * index():      the formats which can only be provided by subdev.
   186	 */
   187	static struct isc_format isc_formats[] = {
   188	{V4L2_PIX_FMT_SBGGR8, MEDIA_BUS_FMT_SBGGR8_1X8, MEDIA_BUS_FMT_SBGGR8_1X8,
   189	1, ISC_PFE_CFG0_BPS_EIGHT, ISC_PFE_CFG0_BPS_EIGHT, ISC_WB_CFG_BAYCFG_BGBG,
   190	ISC_CFA_CFG_BAY_BGBG, ISC_RLP_CFG_MODE_DAT8, ISC_DCFG_IMODE_PACKED8,
   191	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   192	{V4L2_PIX_FMT_SGBRG8, MEDIA_BUS_FMT_SGBRG8_1X8, MEDIA_BUS_FMT_SGBRG8_1X8,
   193	1, ISC_PFE_CFG0_BPS_EIGHT, ISC_PFE_CFG0_BPS_EIGHT, ISC_WB_CFG_BAYCFG_GBGB,
   194	ISC_CFA_CFG_BAY_GBGB, ISC_RLP_CFG_MODE_DAT8, ISC_DCFG_IMODE_PACKED8,
   195	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   196	{V4L2_PIX_FMT_SGRBG8, MEDIA_BUS_FMT_SGRBG8_1X8, MEDIA_BUS_FMT_SGRBG8_1X8,
   197	1, ISC_PFE_CFG0_BPS_EIGHT, ISC_PFE_CFG0_BPS_EIGHT, ISC_WB_CFG_BAYCFG_GRGR,
   198	ISC_CFA_CFG_BAY_GRGR, ISC_RLP_CFG_MODE_DAT8, ISC_DCFG_IMODE_PACKED8,
   199	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   200	{V4L2_PIX_FMT_SRGGB8, MEDIA_BUS_FMT_SRGGB8_1X8, MEDIA_BUS_FMT_SRGGB8_1X8,
   201	1, ISC_PFE_CFG0_BPS_EIGHT, ISC_PFE_CFG0_BPS_EIGHT, ISC_WB_CFG_BAYCFG_RGRG,
   202	ISC_CFA_CFG_BAY_RGRG, ISC_RLP_CFG_MODE_DAT8, ISC_DCFG_IMODE_PACKED8,
   203	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   204	
   205	{V4L2_PIX_FMT_SBGGR10, MEDIA_BUS_FMT_SBGGR10_1X10, MEDIA_BUS_FMT_SBGGR10_1X10,
   206	2, ISC_PFG_CFG0_BPS_TEN, ISC_PFG_CFG0_BPS_TEN, ISC_WB_CFG_BAYCFG_BGBG,
   207	ISC_CFA_CFG_BAY_BGBG, ISC_RLP_CFG_MODE_DAT10, ISC_DCFG_IMODE_PACKED16,
   208	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   209	{V4L2_PIX_FMT_SGBRG10, MEDIA_BUS_FMT_SGBRG10_1X10, MEDIA_BUS_FMT_SGBRG10_1X10,
   210	2, ISC_PFG_CFG0_BPS_TEN, ISC_PFG_CFG0_BPS_TEN, ISC_WB_CFG_BAYCFG_GBGB,
   211	ISC_CFA_CFG_BAY_GBGB, ISC_RLP_CFG_MODE_DAT10, ISC_DCFG_IMODE_PACKED16,
   212	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   213	{V4L2_PIX_FMT_SGRBG10, MEDIA_BUS_FMT_SGRBG10_1X10, MEDIA_BUS_FMT_SGRBG10_1X10,
   214	2, ISC_PFG_CFG0_BPS_TEN, ISC_PFG_CFG0_BPS_TEN, ISC_WB_CFG_BAYCFG_GRGR,
   215	ISC_CFA_CFG_BAY_GRGR, ISC_RLP_CFG_MODE_DAT10, ISC_DCFG_IMODE_PACKED16,
   216	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   217	{V4L2_PIX_FMT_SRGGB10, MEDIA_BUS_FMT_SRGGB10_1X10, MEDIA_BUS_FMT_SRGGB10_1X10,
   218	2, ISC_PFG_CFG0_BPS_TEN, ISC_PFG_CFG0_BPS_TEN, ISC_WB_CFG_BAYCFG_RGRG,
   219	ISC_CFA_CFG_BAY_RGRG, ISC_RLP_CFG_MODE_DAT10, ISC_DCFG_IMODE_PACKED16,
   220	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   221	
   222	{V4L2_PIX_FMT_SBGGR12, MEDIA_BUS_FMT_SBGGR12_1X12, MEDIA_BUS_FMT_SBGGR12_1X12,
   223	2, ISC_PFG_CFG0_BPS_TWELVE, ISC_PFG_CFG0_BPS_TWELVE, ISC_WB_CFG_BAYCFG_BGBG,
   224	ISC_CFA_CFG_BAY_BGBG, ISC_RLP_CFG_MODE_DAT12, ISC_DCFG_IMODE_PACKED16,
   225	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   226	{V4L2_PIX_FMT_SGBRG12, MEDIA_BUS_FMT_SGBRG12_1X12, MEDIA_BUS_FMT_SGBRG12_1X12,
   227	2, ISC_PFG_CFG0_BPS_TWELVE, ISC_PFG_CFG0_BPS_TWELVE, ISC_WB_CFG_BAYCFG_GBGB,
   228	ISC_CFA_CFG_BAY_GBGB, ISC_RLP_CFG_MODE_DAT12, ISC_DCFG_IMODE_PACKED16,
   229	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   230	{V4L2_PIX_FMT_SGRBG12, MEDIA_BUS_FMT_SGRBG12_1X12, MEDIA_BUS_FMT_SGRBG12_1X12,
   231	2, ISC_PFG_CFG0_BPS_TWELVE, ISC_PFG_CFG0_BPS_TWELVE, ISC_WB_CFG_BAYCFG_GRGR,
   232	ISC_CFA_CFG_BAY_GRGR, ISC_RLP_CFG_MODE_DAT12, ISC_DCFG_IMODE_PACKED16,
   233	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   234	{V4L2_PIX_FMT_SRGGB12, MEDIA_BUS_FMT_SRGGB12_1X12, MEDIA_BUS_FMT_SRGGB12_1X12,
   235	2, ISC_PFG_CFG0_BPS_TWELVE, ISC_PFG_CFG0_BPS_TWELVE, ISC_WB_CFG_BAYCFG_RGRG,
   236	ISC_CFA_CFG_BAY_RGRG, ISC_RLP_CFG_MODE_DAT12, ISC_DCFG_IMODE_PACKED16,
   237	ISC_DCTRL_DVIEW_PACKED, 0x0, false, false},
   238	
   239	{V4L2_PIX_FMT_YUYV, MEDIA_BUS_FMT_YUYV8_2X8, MEDIA_BUS_FMT_YUYV8_2X8,
   240	2, ISC_PFE_CFG0_BPS_EIGHT, ISC_PFE_CFG0_BPS_EIGHT, ISC_WB_CFG_BAYCFG_BGBG,
   241	ISC_CFA_CFG_BAY_BGBG, ISC_RLP_CFG_MODE_DAT8, ISC_DCFG_IMODE_PACKED8,
   242	ISC_DCTRL_DVIEW_PACKED, 0x7f, false, false},
   243	};
   244	
   245	static int isc_clk_enable(struct clk_hw *hw)
   246	{
 > 247		struct isc_clk *isc_clk = to_isc_clk(hw);
   248		u32 id = isc_clk->id;
   249		struct regmap *regmap = isc_clk->regmap;
   250		unsigned long flags;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45803 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/1e09ef8c/attachment-0001.obj>
