From: robherring2@gmail.com (Rob Herring)
Date: Fri, 17 May 2013 14:36:28 -0500
Subject: spurious bL cpufreq driver messages
Message-ID: <519686BC.3090101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bL cpufreq driver appears to collide with the cpufreq-cpu0 driver.
There doesn't appear to be a functional problem, but just spurious
prints which indicate it is trying to do something. I think it needs
better checking whether the chip is actually multi-cluster. This is what
I get when I hotplug cpus:

[  909.372319] CPU1: Booted secondary processor
[  909.372616] cpu cpu1: get_cluster_clk_and_freq_table: init_opp_table
failed, cpu: 1, err: -61
[  909.385411] cpu cpu1: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9
[  909.394161] CPU2: shutdown
[  909.400957] CPU2: Booted secondary processor
[  909.401253] cpu cpu2: get_cluster_clk_and_freq_table: init_opp_table
failed, cpu: 2, err: -61
[  909.414044] cpu cpu2: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9

Rob
