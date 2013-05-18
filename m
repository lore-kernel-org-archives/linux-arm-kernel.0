From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 18 May 2013 07:33:48 +0530
Subject: spurious bL cpufreq driver messages
In-Reply-To: <519686BC.3090101@gmail.com>
References: <519686BC.3090101@gmail.com>
Message-ID: <CAKohpom0cGfWvsCf-jaMyu0cQJi2hVk9_0wskEDH2X7MaeHDLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2013 01:06, Rob Herring <robherring2@gmail.com> wrote:
> The bL cpufreq driver appears to collide with the cpufreq-cpu0 driver.
> There doesn't appear to be a functional problem, but just spurious
> prints which indicate it is trying to do something. I think it needs
> better checking whether the chip is actually multi-cluster. This is what
> I get when I hotplug cpus:
>
> [  909.372319] CPU1: Booted secondary processor
> [  909.372616] cpu cpu1: get_cluster_clk_and_freq_table: init_opp_table
> failed, cpu: 1, err: -61
> [  909.385411] cpu cpu1: get_cluster_clk_and_freq_table: Failed to get
> data for cluster: 9
> [  909.394161] CPU2: shutdown
> [  909.400957] CPU2: Booted secondary processor
> [  909.401253] cpu cpu2: get_cluster_clk_and_freq_table: init_opp_table
> failed, cpu: 2, err: -61
> [  909.414044] cpu cpu2: get_cluster_clk_and_freq_table: Failed to get
> data for cluster: 9

See if this fixes your issue.

https://groups.google.com/forum/?fromgroups#!topic/linux.kernel/XJF-82rad4o

Attached too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-arm_big_little_dt-Register-driver-only-if-DT.patch
Type: application/octet-stream
Size: 3967 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130518/88214fa6/attachment.obj>
