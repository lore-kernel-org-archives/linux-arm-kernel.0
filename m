From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 26 Sep 2014 19:39:45 +0800
Subject: [RFC] should we remove soc subnode in all berlin SoC's dts if
 SOC_BUS is selected
Message-ID: <20140926193945.3bb94276@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

We want to export machine name, soc family, chip revision and chipid to
userspace via. the SOC BUS interface, i.e call soc_device_register()

It works perfectly, but there's one side effect: every device nodes will have
an additional level. For example:

/sys/devices/soc.0/xxx.sdhci will be changed to

/sys/devices/soc0/soc.0/xxx.sdhci

This seems a bit ugly. I have one solution: remove "soc" subnodes in all berlin's
dts, then we will have 

/sys/devices/soc0/xxx.sdhci

Is there any better solution? 

Thanks in advance,
Jisheng
