From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Mar 2017 16:44:54 +0800
Subject: [PATCH] clk: sunxi-ng: tighten SoC deps on explicit AllWinner SoCs
In-Reply-To: <20170303071203.xbfu4t2jgwt3low3@lukather>
References: <20170302174357.6246-1-pbrobinson@gmail.com>
 <20170303071203.xbfu4t2jgwt3low3@lukather>
Message-ID: <CAGb2v66GQ4bYWrR-=j_+mKcvxH-gMxhiQamX1E4nr1Ax-B5Bqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 3, 2017 at 3:12 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Mar 02, 2017 at 05:43:57PM +0000, Peter Robinson wrote:
>> Tighten the depends on the various AllWinn SoCs so we don't
>> inadvertantly get clock drivers when we're not wanting them
>> like 32 bit SoC clocks for 64 bit configs. Ensure there's
>> still test coverage though.
>>
>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>
> Applied, thanks!
> Maxime

Just built your for-next branch:

$ make -j8 zImage dtbs modules
scripts/kconfig/conf  --silentoldconfig Kconfig
drivers/clk/sunxi-ng/Kconfig:67: syntax error
drivers/clk/sunxi-ng/Kconfig:66: invalid option
drivers/clk/sunxi-ng/Kconfig:79: syntax error
drivers/clk/sunxi-ng/Kconfig:78: invalid option
drivers/clk/sunxi-ng/Kconfig:91: syntax error
drivers/clk/sunxi-ng/Kconfig:90: invalid option
drivers/clk/sunxi-ng/Kconfig:104: syntax error
drivers/clk/sunxi-ng/Kconfig:103: invalid option
drivers/clk/sunxi-ng/Kconfig:117: syntax error
drivers/clk/sunxi-ng/Kconfig:116: invalid option
drivers/clk/sunxi-ng/Kconfig:129: syntax error
drivers/clk/sunxi-ng/Kconfig:128: invalid option
drivers/clk/sunxi-ng/Kconfig:141: syntax error
drivers/clk/sunxi-ng/Kconfig:140: invalid option
drivers/clk/sunxi-ng/Kconfig:152: syntax error
drivers/clk/sunxi-ng/Kconfig:151: invalid option
scripts/kconfig/Makefile:37: recipe for target 'silentoldconfig' failed
make[2]: *** [silentoldconfig] Error 1
Makefile:548: recipe for target 'silentoldconfig' failed
make[1]: *** [silentoldconfig] Error 2
make: *** No rule to make target 'include/config/auto.conf', needed by
'include/config/kernel.release'.  Stop.
make: *** Waiting for unfinished jobs....

This patch is the culprit. The proper syntax is "depends on", not "depends".


Regards
ChenYu
