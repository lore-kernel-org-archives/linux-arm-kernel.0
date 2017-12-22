From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 22 Dec 2017 14:11:56 +0800
Subject: [clk:clk-next 130/133] drivers/clk/mediatek/clk-mtk.h:44:19:
 warning: 'struct clk_onecell_data' declared inside parameter list will not
 be visible outside of this definition or declaration
In-Reply-To: <201712221239.y5YaQIlV%fengguang.wu@intel.com>
References: <201712221239.y5YaQIlV%fengguang.wu@intel.com>
Message-ID: <1513923116.30687.1.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thanks, i will try to have a fixup
	
	Sean


On Fri, 2017-12-22 at 12:42 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> head:   813bf3417374b0f382d4bfbd712c54794d943c57
> commit: 74cb0d6dde85fef197aca3b2976487e99934309d [130/133] clk: mediatek: fixup test-building of MediaTek clock drivers
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 74cb0d6dde85fef197aca3b2976487e99934309d
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/clk/mediatek/reset.c:22:0:
> >> drivers/clk/mediatek/clk-mtk.h:44:19: warning: 'struct clk_onecell_data' declared inside parameter list will not be visible outside of this definition or declaration
>       int num, struct clk_onecell_data *clk_data);
>                       ^~~~~~~~~~~~~~~~
>    drivers/clk/mediatek/clk-mtk.h:63:19: warning: 'struct clk_onecell_data' declared inside parameter list will not be visible outside of this definition or declaration
>       int num, struct clk_onecell_data *clk_data);
>                       ^~~~~~~~~~~~~~~~
>    drivers/clk/mediatek/clk-mtk.h:145:10: warning: 'struct clk_onecell_data' declared inside parameter list will not be visible outside of this definition or declaration
>       struct clk_onecell_data *clk_data);
>              ^~~~~~~~~~~~~~~~
>    drivers/clk/mediatek/clk-mtk.h:164:11: warning: 'struct clk_onecell_data' declared inside parameter list will not be visible outside of this definition or declaration
>        struct clk_onecell_data *clk_data);
>               ^~~~~~~~~~~~~~~~
>    drivers/clk/mediatek/clk-mtk.h:190:12: warning: 'struct clk_onecell_data' declared inside parameter list will not be visible outside of this definition or declaration
>         struct clk_onecell_data *clk_data);
>                ^~~~~~~~~~~~~~~~
> 
> vim +44 drivers/clk/mediatek/clk-mtk.h
> 
> 4fa04380 James Liao 2015-07-10  35  
> 4fa04380 James Liao 2015-07-10  36  #define FIXED_CLK(_id, _name, _parent, _rate) {		\
> 4fa04380 James Liao 2015-07-10  37  		.id = _id,				\
> 4fa04380 James Liao 2015-07-10  38  		.name = _name,				\
> 4fa04380 James Liao 2015-07-10  39  		.parent = _parent,			\
> 4fa04380 James Liao 2015-07-10  40  		.rate = _rate,				\
> 4fa04380 James Liao 2015-07-10  41  	}
> 4fa04380 James Liao 2015-07-10  42  
> 4fa04380 James Liao 2015-07-10  43  void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
> 4fa04380 James Liao 2015-07-10 @44  		int num, struct clk_onecell_data *clk_data);
> 4fa04380 James Liao 2015-07-10  45  
> 
> :::::: The code at line 44 was first introduced by commit
> :::::: 4fa043806a2cdbf86503068276ab9bba91a726f6 clk: mediatek: Add fixed clocks support for Mediatek SoC.
> 
> :::::: TO: James Liao <jamesjj.liao@mediatek.com>
> :::::: CC: James Liao <jamesjj.liao@mediatek.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
