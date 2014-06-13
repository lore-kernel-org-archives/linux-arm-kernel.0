From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 13 Jun 2014 15:30:20 +0100
Subject: [STLinux Kernel] Latest mainline (3.16 merge window) does not
 boot in B2020/STiH416
In-Reply-To: <539AFCF5.90206@linaro.org>
References: <539AF5B0.6060509@linaro.org>
 <20140613131051.GA28309@griffinp-ThinkPad-X1-Carbon-2nd>
 <539AFCF5.90206@linaro.org>
Message-ID: <20140613143020.GA29920@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

> Thanks Pete. Adding this parameter fixes the problem.
> 
> Any idea why?

Some of the interconnect / core clocks aren't handled properly atm.

I just added some debug in drivers/clk and without clk_ignore_unused
we turn off the clock to DDR :-(

[    9.760022] IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.104
[    9.767831] IP-Config: Complete:
[    9.771065]      device=eth0, hwaddr=5a:83:c2:c5:02:0f, ipaddr=192.168.0.104, mask=255.255.255.0, gw=192.168.0.1
[    9.781238]      host=192.168.0.104, domain=, nis-domain=(none)
[    9.787155]      bootserver=0.0.0.0, rootserver=192.168.0.10, rootpath=
[    9.793589]      nameserver0=192.168.0.1
[    9.797718] clk-m-pix-hdmirx-sas clk->name
[    9.801809] clk-s-tmds-fromphy clk->name
[    9.805727] clk-sysin clk->name
[    9.808855] clockgen-gpu-pll clk->name
[    9.812597] clockgen-ddr-pll clk->name
[    9.816340] clockgen-ddr1 clk->name
[    9.819816] clockgen-ddr0 clk->name

regards,

Pete.
