From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 22 Oct 2015 09:07:33 -0700
Subject: [PATCH] pinctrl-zynq: Initialize early
In-Reply-To: <1445513420-23527-1-git-send-email-mike.looijmans@topic.nl>
References: <1445513420-23527-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <20151022160733.GH5257@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, 2015-10-22 at 01:30PM +0200, Mike Looijmans wrote:
> Supplying pinmux configuration for e.g. gpio pins leads to deferred
> probes because the pinctrl device is probed much later than gpio.
> Move the init call to a much earlier stage so it probes before the
> devices that may need it.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

in general, the change should be OK, but neither on zc702 nor zc706 do I
see a difference in respect to deferred probes. With and without the
patch I see:
    root at zynq:~# dmesg | grep -i defer
    [    0.097021] zynq-gpio e000a000.gpio: could not find pctldev for node /amba/slcr at f8000000/pinctrl at 700/gpio0-default, deferring probe
    root at zynq:~# 

If you have a case this patch improves things though, feel free to add my
Tested-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	Thanks,
	S?ren
