From: lkp@intel.com (kbuild test robot)
Date: Fri, 11 May 2018 00:56:55 +0800
Subject: [xlnx:xlnx_rebase_v4.14 132/918]
 drivers/misc/jesd204b/xilinx_jesd204b.c:29:17: error: field 'hw' has
 incomplete type
Message-ID: <201805110053.O4E3Zovn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   944a760cdb1098e23096c923aef70488fdbd501b
commit: 5d774267f2dcee0cd5158b9ebe3bb58a0fd984e1 [132/918] jesd204b: move the current driver to a folder
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5d774267f2dcee0cd5158b9ebe3bb58a0fd984e1
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/misc/jesd204b/xilinx_jesd204b.c:29:17: error: field 'hw' has incomplete type
     struct clk_hw  hw;
                    ^~
   In file included from include/linux/err.h:5:0,
                    from include/linux/clk.h:15,
                    from drivers/misc/jesd204b/xilinx_jesd204b.c:11:
   drivers/misc/jesd204b/xilinx_jesd204b.c: In function 'jesd204b_clk_enable':
>> include/linux/kernel.h:929:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                   ^~~~~~
   include/linux/compiler.h:554:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:577:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:47:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:35:26: note: in expansion of macro 'container_of'
    #define to_clk_priv(_hw) container_of(_hw, struct child_clk, hw)
                             ^~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:215:2: note: in expansion of macro 'to_clk_priv'
     to_clk_priv(hw)->enabled = true;
     ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c: At top level:
>> drivers/misc/jesd204b/xilinx_jesd204b.c:230:21: error: variable 'clkout_ops' has initializer but incomplete type
    static const struct clk_ops clkout_ops = {
                        ^~~~~~~
>> drivers/misc/jesd204b/xilinx_jesd204b.c:231:3: error: 'const struct clk_ops' has no member named 'recalc_rate'
     .recalc_rate = jesd204b_clk_recalc_rate,
      ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:17: warning: excess elements in struct initializer
     .recalc_rate = jesd204b_clk_recalc_rate,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:17: note: (near initialization for 'clkout_ops')
>> drivers/misc/jesd204b/xilinx_jesd204b.c:232:3: error: 'const struct clk_ops' has no member named 'enable'
     .enable = jesd204b_clk_enable,
      ^~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:12: warning: excess elements in struct initializer
     .enable = jesd204b_clk_enable,
               ^~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:12: note: (near initialization for 'clkout_ops')
>> drivers/misc/jesd204b/xilinx_jesd204b.c:233:3: error: 'const struct clk_ops' has no member named 'disable'
     .disable = jesd204b_clk_disable,
      ^~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:233:13: warning: excess elements in struct initializer
     .disable = jesd204b_clk_disable,
                ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:233:13: note: (near initialization for 'clkout_ops')
>> drivers/misc/jesd204b/xilinx_jesd204b.c:234:3: error: 'const struct clk_ops' has no member named 'is_enabled'
     .is_enabled = jesd204b_clk_is_enabled,
      ^~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:234:16: warning: excess elements in struct initializer
     .is_enabled = jesd204b_clk_is_enabled,
                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:234:16: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c: In function 'jesd204b_probe':
>> drivers/misc/jesd204b/xilinx_jesd204b.c:252:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:252:23: warning: unused variable 'init' [-Wunused-variable]
   drivers/misc/jesd204b/xilinx_jesd204b.c: At top level:
>> drivers/misc/jesd204b/xilinx_jesd204b.c:230:29: error: storage size of 'clkout_ops' isn't known
    static const struct clk_ops clkout_ops = {
                                ^~~~~~~~~~

vim +/hw +29 drivers/misc/jesd204b/xilinx_jesd204b.c

    26	
    27	
    28	struct child_clk {
  > 29		struct clk_hw		hw;
    30		struct jesd204b_state	*st;
    31		unsigned long		rate;
    32		bool			enabled;
    33	};
    34	
  > 35	#define to_clk_priv(_hw) container_of(_hw, struct child_clk, hw)
    36	
    37	static inline void jesd204b_write(struct jesd204b_state *st,
    38					  unsigned reg, unsigned val)
    39	{
    40		iowrite32(val, st->regs + reg);
    41	}
    42	
    43	static inline unsigned int jesd204b_read(struct jesd204b_state *st,
    44						 unsigned reg)
    45	{
    46		return ioread32(st->regs + reg);
    47	}
    48	
    49	static ssize_t jesd204b_laneinfo_read(struct device *dev,
    50					      struct device_attribute *attr,
    51					      char *buf, unsigned lane)
    52	{
    53		struct jesd204b_state *st = dev_get_drvdata(dev);
    54		int ret;
    55		unsigned val1, val2, val3;
    56	
    57		val1 = jesd204b_read(st, XLNX_JESD204_REG_ID_L(lane));
    58		val2 = jesd204b_read(st, XLNX_JESD204_REG_LANE_F(lane));
    59		val3 = jesd204b_read(st, XLNX_JESD204_REG_SCR_S_HD_CF(lane));
    60		ret = sprintf(buf,
    61			      "DID: %d, BID: %d, LID: %d, L: %d, SCR: %d, F: %d\n",
    62			      XLNX_JESD204_LANE_DID(val1),
    63			      XLNX_JESD204_LANE_BID(val1),
    64			      XLNX_JESD204_LANE_LID(val1),
    65			      XLNX_JESD204_LANE_L(val1),
    66			      XLNX_JESD204_LANE_SCR(val3),
    67			      XLNX_JESD204_LANE_F(val2));
    68	
    69		val1 = jesd204b_read(st, XLNX_JESD204_REG_LANE_K(lane));
    70		val2 = jesd204b_read(st, XLNX_JESD204_REG_M_N_ND_CS(lane));
    71	
    72		ret += sprintf(buf + ret,
    73			       "K: %d, M: %d, N: %d, CS: %d, S: %d, N': %d, HD: %d\n",
    74			       XLNX_JESD204_LANE_K(val1),
    75			       XLNX_JESD204_LANE_M(val2),
    76			       XLNX_JESD204_LANE_N(val2),
    77			       XLNX_JESD204_LANE_CS(val2),
    78			       XLNX_JESD204_LANE_S(val3),
    79			       XLNX_JESD204_LANE_ND(val2),
    80			       XLNX_JESD204_LANE_HD(val3));
    81	
    82		val1 = jesd204b_read(st, XLNX_JESD204_REG_FCHK(lane));
    83		ret += sprintf(buf + ret, "FCHK: 0x%X, CF: %d\n",
    84			       XLNX_JESD204_LANE_FCHK(val1),
    85			       XLNX_JESD204_LANE_CF(val3));
    86	
    87		val1 = jesd204b_read(st, XLNX_JESD204_REG_SC2_ADJ_CTRL(lane));
    88		val2 = jesd204b_read(st, XLNX_JESD204_REG_LANE_VERSION(lane));
    89		ret += sprintf(buf + ret,
    90			"ADJCNT: %d, PHYADJ: %d, ADJDIR: %d, JESDV: %d, SUBCLASS: %d\n",
    91			       XLNX_JESD204_LANE_ADJ_CNT(val1),
    92			       XLNX_JESD204_LANE_PHASE_ADJ_REQ(val1),
    93			       XLNX_JESD204_LANE_ADJ_CNT_DIR(val1),
    94			       XLNX_JESD204_LANE_JESDV(val2),
    95			       XLNX_JESD204_LANE_SUBCLASS(val2));
    96	
    97		ret += sprintf(buf + ret, "MFCNT : 0x%X\n",
    98			       jesd204b_read(st, XLNX_JESD204_REG_TM_MFC_CNT(lane)));
    99		ret += sprintf(buf + ret, "ILACNT: 0x%X\n",
   100			       jesd204b_read(st, XLNX_JESD204_REG_TM_ILA_CNT(lane)));
   101		ret += sprintf(buf + ret, "ERRCNT: 0x%X\n",
   102			       jesd204b_read(st, XLNX_JESD204_REG_TM_ERR_CNT(lane)));
   103		ret += sprintf(buf + ret, "BUFCNT: 0x%X\n",
   104			       jesd204b_read(st, XLNX_JESD204_REG_TM_BUF_ADJ(lane)));
   105		ret += sprintf(buf + ret, "LECNT: 0x%X\n",
   106			       jesd204b_read(st,
   107			       XLNX_JESD204_REG_TM_LINK_ERR_CNT(lane)));
   108	
   109		ret += sprintf(buf + ret, "FC: %lu\n", st->rate);
   110	
   111		return ret;
   112	}
   113	
   114	#define JESD_LANE(_x)							    \
   115	static ssize_t jesd204b_lane##_x##_info_read(struct device *dev,	    \
   116						     struct device_attribute *attr, \
   117						     char *buf)			    \
   118	{									    \
   119		return jesd204b_laneinfo_read(dev, attr, buf, _x);		    \
   120	}									    \
   121	static DEVICE_ATTR(lane##_x##_info, S_IRUSR, jesd204b_lane##_x##_info_read, \
   122			   NULL)
   123	
   124	JESD_LANE(0);
   125	JESD_LANE(1);
   126	JESD_LANE(2);
   127	JESD_LANE(3);
   128	JESD_LANE(4);
   129	JESD_LANE(5);
   130	JESD_LANE(6);
   131	JESD_LANE(7);
   132	
   133	static ssize_t jesd204b_lane_syscstat_read(struct device *dev,
   134				struct device_attribute *attr,
   135				char *buf, unsigned lane)
   136	{
   137		struct jesd204b_state *st = dev_get_drvdata(dev);
   138		unsigned stat;
   139	
   140		stat = jesd204b_read(st, XLNX_JESD204_REG_SYNC_ERR_STAT);
   141	
   142		return sprintf(buf,
   143				"NOT_IN_TAB: %d, DISPARITY: %d, UNEXPECTED_K: %d\n",
   144				stat & XLNX_JESD204_SYNC_ERR_NOT_IN_TAB(lane),
   145				stat & XLNX_JESD204_SYNC_ERR_DISPARITY(lane),
   146				stat & XLNX_JESD204_SYNC_ERR_UNEXPECTED_K(lane));
   147	}
   148	
   149	#define JESD_SYNCSTAT_LANE(_x)						       \
   150	static ssize_t jesd204b_lane##_x##_syncstat_read(struct device *dev,	       \
   151							 struct device_attribute *attr,\
   152							 char *buf)		       \
   153	{									       \
   154		return jesd204b_lane_syscstat_read(dev, attr, buf, _x);		       \
   155	}									       \
   156	static DEVICE_ATTR(lane##_x##_syncstat, S_IRUSR,			       \
   157			   jesd204b_lane##_x##_syncstat_read, NULL)
   158	
   159	JESD_SYNCSTAT_LANE(0);
   160	JESD_SYNCSTAT_LANE(1);
   161	JESD_SYNCSTAT_LANE(2);
   162	JESD_SYNCSTAT_LANE(3);
   163	JESD_SYNCSTAT_LANE(4);
   164	JESD_SYNCSTAT_LANE(5);
   165	JESD_SYNCSTAT_LANE(6);
   166	JESD_SYNCSTAT_LANE(7);
   167	
   168	static ssize_t jesd204b_reg_write(struct device *dev,
   169					  struct device_attribute *attr,
   170					  const char *buf, size_t count)
   171	{
   172		struct jesd204b_state *st = dev_get_drvdata(dev);
   173		unsigned val;
   174		int ret;
   175	
   176		ret = sscanf(buf, "%i %i", &st->addr, &val);
   177		if (ret == 2)
   178			jesd204b_write(st, st->addr, val);
   179	
   180		return count;
   181	}
   182	
   183	static ssize_t jesd204b_reg_read(struct device *dev,
   184					 struct device_attribute *attr,
   185					 char *buf)
   186	{
   187		struct jesd204b_state *st = dev_get_drvdata(dev);
   188	
   189		return sprintf(buf, "0x%X\n", jesd204b_read(st, st->addr));
   190	}
   191	
   192	static DEVICE_ATTR(reg_access, S_IWUSR | S_IRUSR, jesd204b_reg_read,
   193			   jesd204b_reg_write);
   194	
   195	static ssize_t jesd204b_syncreg_read(struct device *dev,
   196					     struct device_attribute *attr,
   197					     char *buf)
   198	{
   199		struct jesd204b_state *st = dev_get_drvdata(dev);
   200	
   201		return sprintf(buf, "0x%X\n", jesd204b_read(st,
   202						XLNX_JESD204_REG_SYNC_STATUS));
   203	}
   204	
   205	static DEVICE_ATTR(sync_status, S_IRUSR, jesd204b_syncreg_read, NULL);
   206	
   207	static unsigned long jesd204b_clk_recalc_rate(struct clk_hw *hw,
   208						      unsigned long parent_rate)
   209	{
   210		return parent_rate;
   211	}
   212	
   213	static int jesd204b_clk_enable(struct clk_hw *hw)
   214	{
 > 215		to_clk_priv(hw)->enabled = true;
   216	
   217		return 0;
   218	}
   219	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48869 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180511/a7bfeef0/attachment-0001.gz>
