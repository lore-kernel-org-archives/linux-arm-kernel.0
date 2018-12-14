Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:32:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA29D20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HtMZrZEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA29D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ry5xiWbINsdZgrQaYJBh9We1usoJkgWMVPArU3CQNHo=; b=HtM
	ZrZEax8Xxj6M2HkofUunWA0SY7zfKNM14CoZA3iMEq5iY7tAtZ4Gt1WmJUZqFL9LjN0E3eEEILD+v
	9P2/rLDiBhFoheFmnWWjea0rSlszPjkhcWQBz1Fp7v8963OBGaB3TwLVHzW9TUtf5Ols59AvbO9Ks
	VokeoOdw6Cn6XpufTEvMBrZqb/qi06v7UJausmNupikgUDXMGznCPPg/wlxGVgFH6jdJzLZsv7N2P
	W44f6Br8v1IAr2u/sVuk0Y+enCGa6tFKm9qSHN4QCsAK7CZhcqMylUodyiE2OTEPmmQto4kkEXzuG
	3JkvV0xablmzU/8nxtoirT2lhf4EloA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXjpP-0002Ql-QP; Fri, 14 Dec 2018 09:32:15 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXjpL-0002P0-Bp
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 09:32:14 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Dec 2018 01:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
 d="gz'50?scan'50,208,50";a="118520785"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Dec 2018 01:31:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gXjp3-0005cP-TI; Fri, 14 Dec 2018 17:31:53 +0800
Date: Fri, 14 Dec 2018 17:31:14 +0800
From: kbuild test robot <lkp@intel.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [clk:clk-doc 4/5] drivers/clk/nxp/clk-lpc32xx.c:1094:5: error:
 'struct clk_fixed_rate' has no member named 'flags'
Message-ID: <201812141711.PtX1q2JM%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_013211_507574_868BEE35 
X-CRM114-Status: GOOD (  12.62  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kbuild-all@01.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-doc
head:   9369ad9e3dd4ec5a5d189825a49c1b76bb733571
commit: 9274efae17dcaf8bb2f8abf802ea254ae8810794 [4/5] clk: Remove 'flags' member of struct clk_fixed_rate
config: arm-lpc32xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9274efae17dcaf8bb2f8abf802ea254ae8810794
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> drivers/clk/nxp/clk-lpc32xx.c:1094:5: error: 'struct clk_fixed_rate' has no member named 'flags'
       .flags = (_flags),    \
        ^
>> drivers/clk/nxp/clk-lpc32xx.c:1228:2: note: in expansion of macro 'LPC32XX_DEFINE_FIXED'
     LPC32XX_DEFINE_FIXED(RTC, 32768, 0),
     ^~~~~~~~~~~~~~~~~~~~
   drivers/clk/nxp/clk-lpc32xx.c: In function 'lpc32xx_clk_register':
   drivers/clk/nxp/clk-lpc32xx.c:1471:21: error: 'struct clk_fixed_rate' has no member named 'flags'
       parents[0], fixed->flags, fixed->fixed_rate);
                        ^~

vim +1094 drivers/clk/nxp/clk-lpc32xx.c

f7c82a60 Vladimir Zapolskiy 2015-12-06  1087  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1088  #define LPC32XX_DEFINE_FIXED(_idx, _rate, _flags)			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1089  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1090  	.type = CLK_FIXED,						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1091  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1092  		.f = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1093  			.fixed_rate = (_rate),				\
f7c82a60 Vladimir Zapolskiy 2015-12-06 @1094  			.flags = (_flags),				\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1095  		},							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1096  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1097  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1098  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1099  #define LPC32XX_DEFINE_PLL(_idx, _name, _reg, _enable)			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1100  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1101  	.type = CLK_LPC32XX_PLL,					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1102  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1103  		.hw0 = {						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1104  			.ops = &clk_ ##_name ## _ops,			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1105  			{						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1106  				.pll = {				\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1107  					.reg = LPC32XX_CLKPWR_ ## _reg,	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1108  					.enable = (_enable),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1109  				},					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1110  			},						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1111  		},							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1112  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1113  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1114  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1115  #define LPC32XX_DEFINE_MUX(_idx, _reg, _shift, _mask, _table, _flags)	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1116  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1117  	.type = CLK_MUX,						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1118  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1119  		.hw0 = {						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1120  			.ops = (_flags & CLK_MUX_READ_ONLY ?		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1121  				&lpc32xx_clk_mux_ro_ops :		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1122  				&lpc32xx_clk_mux_ops),			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1123  			{						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1124  				.mux = {				\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1125  					.reg = LPC32XX_CLKPWR_ ## _reg,	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1126  					.mask = (_mask),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1127  					.shift = (_shift),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1128  					.table = (_table),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1129  					.flags = (_flags),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1130  				},					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1131  			},						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1132  		},							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1133  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1134  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1135  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1136  #define LPC32XX_DEFINE_DIV(_idx, _reg, _shift, _width, _table, _flags)	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1137  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1138  	.type = CLK_DIV,						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1139  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1140  		.hw0 = {						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1141  			.ops = &lpc32xx_clk_divider_ops,		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1142  			{						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1143  				.div = {				\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1144  					.reg = LPC32XX_CLKPWR_ ## _reg,	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1145  					.shift = (_shift),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1146  					.width = (_width),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1147  					.table = (_table),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1148  					.flags = (_flags),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1149  				 },					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1150  			},						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1151  		 },							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1152  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1153  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1154  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1155  #define LPC32XX_DEFINE_GATE(_idx, _reg, _bit, _flags)			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1156  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1157  	.type = CLK_GATE,						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1158  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1159  		.hw0 = {						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1160  			.ops = &lpc32xx_clk_gate_ops,			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1161  			{						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1162  				.gate = {				\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1163  					.reg = LPC32XX_CLKPWR_ ## _reg,	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1164  					.bit_idx = (_bit),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1165  					.flags = (_flags),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1166  				},					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1167  			},						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1168  		},							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1169  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1170  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1171  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1172  #define LPC32XX_DEFINE_CLK(_idx, _reg, _e, _em, _d, _dm, _b, _bm, _ops)	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1173  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1174  	.type = CLK_LPC32XX,						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1175  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1176  		.hw0 = {						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1177  			.ops = &(_ops),					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1178  			{						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1179  				.clk = {				\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1180  					.reg = LPC32XX_CLKPWR_ ## _reg,	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1181  					.enable = (_e),			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1182  					.enable_mask = (_em),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1183  					.disable = (_d),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1184  					.disable_mask = (_dm),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1185  					.busy = (_b),			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1186  					.busy_mask = (_bm),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1187  				},					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1188  			},						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1189  		},							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1190  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1191  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1192  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1193  #define LPC32XX_DEFINE_USB(_idx, _ce, _cd, _cm, _e, _b, _ops)		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1194  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1195  	.type = CLK_LPC32XX_USB,					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1196  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1197  		.hw0 = {						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1198  			.ops = &(_ops),					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1199  			{						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1200  				.usb_clk = {				\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1201  					.ctrl_enable = (_ce),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1202  					.ctrl_disable = (_cd),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1203  					.ctrl_mask = (_cm),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1204  					.enable = (_e),			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1205  					.busy = (_b),			\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1206  				}					\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1207  			},						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1208  		}							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1209  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1210  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1211  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1212  #define LPC32XX_DEFINE_COMPOSITE(_idx, _mux, _div, _gate)		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1213  [CLK_PREFIX(_idx)] = {							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1214  	.type = CLK_COMPOSITE,						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1215  	{								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1216  		.hw1 = {						\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1217  		.mux = (CLK_PREFIX(_mux) == LPC32XX_CLK__NULL ? NULL :	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1218  			&clk_hw_proto[CLK_PREFIX(_mux)].hw0),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1219  		.div = (CLK_PREFIX(_div) == LPC32XX_CLK__NULL ? NULL :	\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1220  			&clk_hw_proto[CLK_PREFIX(_div)].hw0),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1221  		.gate = (CLK_PREFIX(_gate) == LPC32XX_CLK__NULL ? NULL :\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1222  			 &clk_hw_proto[CLK_PREFIX(_gate)].hw0),		\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1223  		},							\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1224  	},								\
f7c82a60 Vladimir Zapolskiy 2015-12-06  1225  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  1226  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1227  static struct clk_hw_proto clk_hw_proto[LPC32XX_CLK_HW_MAX] = {
f7c82a60 Vladimir Zapolskiy 2015-12-06 @1228  	LPC32XX_DEFINE_FIXED(RTC, 32768, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1229  	LPC32XX_DEFINE_PLL(PLL397X, pll_397x, HCLKPLL_CTRL, BIT(1)),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1230  	LPC32XX_DEFINE_PLL(HCLK_PLL, hclk_pll, HCLKPLL_CTRL, PLL_CTRL_ENABLE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1231  	LPC32XX_DEFINE_PLL(USB_PLL, usb_pll, USB_CTRL, PLL_CTRL_ENABLE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1232  	LPC32XX_DEFINE_GATE(OSC, OSC_CTRL, 0, CLK_GATE_SET_TO_DISABLE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1233  	LPC32XX_DEFINE_GATE(USB, USB_CTRL, 18, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1234  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1235  	LPC32XX_DEFINE_DIV(HCLK_DIV_PERIPH, HCLKDIV_CTRL, 2, 5, NULL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1236  			   CLK_DIVIDER_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1237  	LPC32XX_DEFINE_DIV(HCLK_DIV, HCLKDIV_CTRL, 0, 2, clk_hclk_div_table,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1238  			   CLK_DIVIDER_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1239  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1240  	/* Register 3 read-only muxes with a single control PWR_CTRL[2] */
f7c82a60 Vladimir Zapolskiy 2015-12-06  1241  	LPC32XX_DEFINE_MUX(SYSCLK_PERIPH_MUX, PWR_CTRL, 2, 0x1, NULL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1242  			   CLK_MUX_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1243  	LPC32XX_DEFINE_MUX(SYSCLK_HCLK_MUX, PWR_CTRL, 2, 0x1, NULL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1244  			   CLK_MUX_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1245  	LPC32XX_DEFINE_MUX(SYSCLK_ARM_MUX, PWR_CTRL, 2, 0x1, NULL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1246  			   CLK_MUX_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1247  	/* Register 2 read-only muxes with a single control PWR_CTRL[10] */
f7c82a60 Vladimir Zapolskiy 2015-12-06  1248  	LPC32XX_DEFINE_MUX(PERIPH_HCLK_MUX, PWR_CTRL, 10, 0x1, NULL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1249  			   CLK_MUX_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1250  	LPC32XX_DEFINE_MUX(PERIPH_ARM_MUX, PWR_CTRL, 10, 0x1, NULL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1251  			   CLK_MUX_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1252  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1253  	/* 3 always on gates with a single control PWR_CTRL[0] same as OSC */
f7c82a60 Vladimir Zapolskiy 2015-12-06  1254  	LPC32XX_DEFINE_GATE(PERIPH, PWR_CTRL, 0, CLK_GATE_SET_TO_DISABLE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1255  	LPC32XX_DEFINE_GATE(HCLK, PWR_CTRL, 0, CLK_GATE_SET_TO_DISABLE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1256  	LPC32XX_DEFINE_GATE(ARM, PWR_CTRL, 0, CLK_GATE_SET_TO_DISABLE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1257  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1258  	LPC32XX_DEFINE_GATE(ARM_VFP, DEBUG_CTRL, 4, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1259  	LPC32XX_DEFINE_GATE(DMA, DMA_CLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1260  	LPC32XX_DEFINE_CLK(DDRAM, HCLKDIV_CTRL, 0x0, BIT(8) | BIT(7),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1261  		   0x0, BIT(8) | BIT(7), 0x0, BIT(1) | BIT(0), clk_ddram_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1262  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1263  	LPC32XX_DEFINE_GATE(TIMER0, TIMCLK_CTRL1, 2, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1264  	LPC32XX_DEFINE_GATE(TIMER1, TIMCLK_CTRL1, 3, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1265  	LPC32XX_DEFINE_GATE(TIMER2, TIMCLK_CTRL1, 4, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1266  	LPC32XX_DEFINE_GATE(TIMER3, TIMCLK_CTRL1, 5, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1267  	LPC32XX_DEFINE_GATE(TIMER4, TIMCLK_CTRL1, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1268  	LPC32XX_DEFINE_GATE(TIMER5, TIMCLK_CTRL1, 1, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1269  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1270  	LPC32XX_DEFINE_GATE(SSP0, SSP_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1271  	LPC32XX_DEFINE_GATE(SSP1, SSP_CTRL, 1, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1272  	LPC32XX_DEFINE_GATE(SPI1, SPI_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1273  	LPC32XX_DEFINE_GATE(SPI2, SPI_CTRL, 4, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1274  	LPC32XX_DEFINE_GATE(I2S0, I2S_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1275  	LPC32XX_DEFINE_GATE(I2S1, I2S_CTRL, 1, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1276  	LPC32XX_DEFINE_GATE(I2C1, I2CCLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1277  	LPC32XX_DEFINE_GATE(I2C2, I2CCLK_CTRL, 1, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1278  	LPC32XX_DEFINE_GATE(WDOG, TIMCLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1279  	LPC32XX_DEFINE_GATE(HSTIMER, TIMCLK_CTRL, 1, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1280  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1281  	LPC32XX_DEFINE_GATE(KEY, KEYCLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1282  	LPC32XX_DEFINE_GATE(MCPWM, TIMCLK_CTRL1, 6, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1283  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1284  	LPC32XX_DEFINE_MUX(PWM1_MUX, PWMCLK_CTRL, 1, 0x1, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1285  	LPC32XX_DEFINE_DIV(PWM1_DIV, PWMCLK_CTRL, 4, 4, NULL,
f84d42a9 Vladimir Zapolskiy 2016-10-07  1286  			   CLK_DIVIDER_ONE_BASED),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1287  	LPC32XX_DEFINE_GATE(PWM1_GATE, PWMCLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1288  	LPC32XX_DEFINE_COMPOSITE(PWM1, PWM1_MUX, PWM1_DIV, PWM1_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1289  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1290  	LPC32XX_DEFINE_MUX(PWM2_MUX, PWMCLK_CTRL, 3, 0x1, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1291  	LPC32XX_DEFINE_DIV(PWM2_DIV, PWMCLK_CTRL, 8, 4, NULL,
f84d42a9 Vladimir Zapolskiy 2016-10-07  1292  			   CLK_DIVIDER_ONE_BASED),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1293  	LPC32XX_DEFINE_GATE(PWM2_GATE, PWMCLK_CTRL, 2, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1294  	LPC32XX_DEFINE_COMPOSITE(PWM2, PWM2_MUX, PWM2_DIV, PWM2_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1295  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1296  	LPC32XX_DEFINE_MUX(UART3_MUX, UART3_CLK_CTRL, 16, 0x1, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1297  	LPC32XX_DEFINE_CLK(UART3_DIV, UART3_CLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1298  			   0, 0, 0, 0, 0, 0, lpc32xx_uart_div_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1299  	LPC32XX_DEFINE_GATE(UART3_GATE, UART_CLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1300  	LPC32XX_DEFINE_COMPOSITE(UART3, UART3_MUX, UART3_DIV, UART3_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1301  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1302  	LPC32XX_DEFINE_MUX(UART4_MUX, UART4_CLK_CTRL, 16, 0x1, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1303  	LPC32XX_DEFINE_CLK(UART4_DIV, UART4_CLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1304  			   0, 0, 0, 0, 0, 0, lpc32xx_uart_div_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1305  	LPC32XX_DEFINE_GATE(UART4_GATE, UART_CLK_CTRL, 1, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1306  	LPC32XX_DEFINE_COMPOSITE(UART4, UART4_MUX, UART4_DIV, UART4_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1307  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1308  	LPC32XX_DEFINE_MUX(UART5_MUX, UART5_CLK_CTRL, 16, 0x1, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1309  	LPC32XX_DEFINE_CLK(UART5_DIV, UART5_CLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1310  			   0, 0, 0, 0, 0, 0, lpc32xx_uart_div_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1311  	LPC32XX_DEFINE_GATE(UART5_GATE, UART_CLK_CTRL, 2, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1312  	LPC32XX_DEFINE_COMPOSITE(UART5, UART5_MUX, UART5_DIV, UART5_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1313  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1314  	LPC32XX_DEFINE_MUX(UART6_MUX, UART6_CLK_CTRL, 16, 0x1, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1315  	LPC32XX_DEFINE_CLK(UART6_DIV, UART6_CLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1316  			   0, 0, 0, 0, 0, 0, lpc32xx_uart_div_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1317  	LPC32XX_DEFINE_GATE(UART6_GATE, UART_CLK_CTRL, 3, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1318  	LPC32XX_DEFINE_COMPOSITE(UART6, UART6_MUX, UART6_DIV, UART6_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1319  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1320  	LPC32XX_DEFINE_CLK(IRDA, IRDA_CLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1321  			   0, 0, 0, 0, 0, 0, lpc32xx_uart_div_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1322  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1323  	LPC32XX_DEFINE_MUX(TEST1_MUX, TEST_CLK_CTRL, 5, 0x3,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1324  			   test1_mux_table, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1325  	LPC32XX_DEFINE_GATE(TEST1_GATE, TEST_CLK_CTRL, 4, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1326  	LPC32XX_DEFINE_COMPOSITE(TEST1, TEST1_MUX, _NULL, TEST1_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1327  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1328  	LPC32XX_DEFINE_MUX(TEST2_MUX, TEST_CLK_CTRL, 1, 0x7,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1329  			   test2_mux_table, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1330  	LPC32XX_DEFINE_GATE(TEST2_GATE, TEST_CLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1331  	LPC32XX_DEFINE_COMPOSITE(TEST2, TEST2_MUX, _NULL, TEST2_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1332  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1333  	LPC32XX_DEFINE_MUX(SYS, SYSCLK_CTRL, 0, 0x1, NULL, CLK_MUX_READ_ONLY),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1334  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1335  	LPC32XX_DEFINE_DIV(USB_DIV_DIV, USB_DIV, 0, 4, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1336  	LPC32XX_DEFINE_GATE(USB_DIV_GATE, USB_CTRL, 17, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1337  	LPC32XX_DEFINE_COMPOSITE(USB_DIV, _NULL, USB_DIV_DIV, USB_DIV_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1338  
f84d42a9 Vladimir Zapolskiy 2016-10-07  1339  	LPC32XX_DEFINE_DIV(SD_DIV, MS_CTRL, 0, 4, NULL, CLK_DIVIDER_ONE_BASED),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1340  	LPC32XX_DEFINE_CLK(SD_GATE, MS_CTRL, BIT(5) | BIT(9), BIT(5) | BIT(9),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1341  			   0x0, BIT(5) | BIT(9), 0x0, 0x0, clk_mask_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1342  	LPC32XX_DEFINE_COMPOSITE(SD, _NULL, SD_DIV, SD_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1343  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1344  	LPC32XX_DEFINE_DIV(LCD_DIV, LCDCLK_CTRL, 0, 5, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1345  	LPC32XX_DEFINE_GATE(LCD_GATE, LCDCLK_CTRL, 5, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1346  	LPC32XX_DEFINE_COMPOSITE(LCD, _NULL, LCD_DIV, LCD_GATE),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1347  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1348  	LPC32XX_DEFINE_CLK(MAC, MACCLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1349  			   BIT(2) | BIT(1) | BIT(0), BIT(2) | BIT(1) | BIT(0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1350  			   BIT(2) | BIT(1) | BIT(0), BIT(2) | BIT(1) | BIT(0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1351  			   0x0, 0x0, clk_mask_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1352  	LPC32XX_DEFINE_CLK(SLC, FLASHCLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1353  			   BIT(2) | BIT(0), BIT(2) | BIT(0), 0x0,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1354  			   BIT(0), BIT(1), BIT(2) | BIT(1), clk_mask_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1355  	LPC32XX_DEFINE_CLK(MLC, FLASHCLK_CTRL,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1356  			   BIT(1), BIT(2) | BIT(1), 0x0, BIT(1),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1357  			   BIT(2) | BIT(0), BIT(2) | BIT(0), clk_mask_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1358  	/*
f7c82a60 Vladimir Zapolskiy 2015-12-06  1359  	 * ADC/TS clock unfortunately cannot be registered as a composite one
f7c82a60 Vladimir Zapolskiy 2015-12-06  1360  	 * due to a different connection of gate, div and mux, e.g. gating it
f7c82a60 Vladimir Zapolskiy 2015-12-06  1361  	 * won't mean that the clock is off, if peripheral clock is its parent:
f7c82a60 Vladimir Zapolskiy 2015-12-06  1362  	 *
f7c82a60 Vladimir Zapolskiy 2015-12-06  1363  	 * rtc-->[gate]-->|     |
f7c82a60 Vladimir Zapolskiy 2015-12-06  1364  	 *                | mux |--> adc/ts
f7c82a60 Vladimir Zapolskiy 2015-12-06  1365  	 * pclk-->[div]-->|     |
f7c82a60 Vladimir Zapolskiy 2015-12-06  1366  	 *
f7c82a60 Vladimir Zapolskiy 2015-12-06  1367  	 * Constraints:
f7c82a60 Vladimir Zapolskiy 2015-12-06  1368  	 * ADC --- resulting clock must be <= 4.5 MHz
f7c82a60 Vladimir Zapolskiy 2015-12-06  1369  	 * TS  --- resulting clock must be <= 400 KHz
f7c82a60 Vladimir Zapolskiy 2015-12-06  1370  	 */
f7c82a60 Vladimir Zapolskiy 2015-12-06  1371  	LPC32XX_DEFINE_DIV(ADC_DIV, ADCCLK_CTRL1, 0, 8, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1372  	LPC32XX_DEFINE_GATE(ADC_RTC, ADCCLK_CTRL, 0, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1373  	LPC32XX_DEFINE_MUX(ADC, ADCCLK_CTRL1, 8, 0x1, NULL, 0),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1374  
f7c82a60 Vladimir Zapolskiy 2015-12-06  1375  	/* USB controller clocks */
f7c82a60 Vladimir Zapolskiy 2015-12-06  1376  	LPC32XX_DEFINE_USB(USB_AHB,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1377  			   BIT(24), 0x0, BIT(24), BIT(4), 0, clk_usb_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1378  	LPC32XX_DEFINE_USB(USB_OTG,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1379  			   0x0, 0x0, 0x0, BIT(3), 0, clk_usb_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1380  	LPC32XX_DEFINE_USB(USB_I2C,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1381  			   0x0, BIT(23), BIT(23), BIT(2), 0, clk_usb_i2c_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1382  	LPC32XX_DEFINE_USB(USB_DEV,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1383  			   BIT(22), 0x0, BIT(22), BIT(1), BIT(0), clk_usb_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1384  	LPC32XX_DEFINE_USB(USB_HOST,
f7c82a60 Vladimir Zapolskiy 2015-12-06  1385  			   BIT(21), 0x0, BIT(21), BIT(0), BIT(1), clk_usb_ops),
f7c82a60 Vladimir Zapolskiy 2015-12-06  1386  };
f7c82a60 Vladimir Zapolskiy 2015-12-06  1387  

:::::: The code at line 1094 was first introduced by commit
:::::: f7c82a60ba26c2f003662bcb2cff131021c1e828 clk: lpc32xx: add common clock framework driver

:::::: TO: Vladimir Zapolskiy <vz@mleia.com>
:::::: CC: Michael Turquette <mturquette@baylibre.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--UlVJffcvxoiEqYs2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--UlVJffcvxoiEqYs2--

