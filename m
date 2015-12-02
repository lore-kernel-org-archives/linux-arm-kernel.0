From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 2 Dec 2015 11:18:58 +0000
Subject: [RFC] rk3368 idle states
Message-ID: <20151202111858.GB18981@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

while reviewing other dts idle states bindings I spotted the following
snippet in arch/arm64/boot/dts/rockchip/rk3368.dtsi:

cpu_sleep: cpu-sleep-0 {
       compatible = "arm,idle-state";
       arm,psci-suspend-param = <0x1010000>;
       entry-latency-us = <0x3fffffff>;
       exit-latency-us = <0x40000000>;
       min-residency-us = <0xffffffff>;
};

Could you please explain to me how you obtained these residency/latency
values ? They make NO sense whatsoever and I am quite tempted to
ask you to remove this data from the dts file, it is just wrong.

Thanks,
Lorenzo
