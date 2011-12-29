From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 29 Dec 2011 14:21:03 +0800
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111229062102.GA2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's still a bug that, after rmmod module, cpu0 still has cpufreq
sysfs entry.

cpufreq_unregister_driver can not clean up everything.

unfortunately, I don't have much time to debug cpufreq core.

Log:
root at ubuntu:~# insmod /clk-reg-cpufreq.ko 
clk_reg_cpufreq: regulator cpu get failed.
trying to register driver clk-reg
adding CPU 0
CPU 1 already managed, adding link
CPU 2 already managed, adding link
CPU 3 already managed, adding link
setting new policy for CPU 0: 198000 - 996000 kHz
new min and max freqs are 198000 - 996000 kHz
governor switch
__cpufreq_governor for CPU 0, event 1
governor: change or update limits
__cpufreq_governor for CPU 0, event 3
target for CPU 0: 792000 kHz, relation 0
initialization complete
adding CPU 1
adding CPU 2
adding CPU 3
driver clk-reg up and running
root at ubuntu:~# 
root at ubuntu:~# 
root at ubuntu:~# 
root at ubuntu:~# rmmod clk-reg-cpufreq
unregistering driver clk-reg
unregistering CPU 0
removing link for cpu 1
removing link for cpu 2
removing link for cpu 3
__cpufreq_governor for CPU 0, event 2
last reference is dropped
waiting for dropping of refcount
wait complete
adding CPU 1
Restoring governor userspace for cpu 1
CPU 0 already managed, adding link
CPU 2 already managed, adding link
CPU 3 already managed, adding link
setting new policy for CPU 1: 198000 - 996000 kHz
new min and max freqs are 198000 - 996000 kHz
governor switch
__cpufreq_governor for CPU 1, event 1
governor: change or update limits
__cpufreq_governor for CPU 1, event 3
target for CPU 1: 792000 kHz, relation 0
initialization complete
unregistering CPU 0
removing link
unregistering CPU 1
removing link for cpu 2
removing link for cpu 3
__cpufreq_governor for CPU 1, event 2
last reference is dropped
waiting for dropping of refcount
wait complete
adding CPU 2
Restoring governor userspace for cpu 2
CPU 0 already managed, adding link
CPU 1 already managed, adding link
CPU 3 already managed, adding link
setting new policy for CPU 2: 198000 - 996000 kHz
new min and max freqs are 198000 - 996000 kHz
governor switch
__cpufreq_governor for CPU 2, event 1
governor: change or update limits
__cpufreq_governor for CPU 2, event 3
target for CPU 2: 792000 kHz, relation 0
initialization complete
unregistering CPU 1
removing link
unregistering CPU 2
removing link for cpu 0
removing link for cpu 3
__cpufreq_governor for CPU 2, event 2
last reference is dropped
waiting for dropping of refcount
wait complete
adding CPU 0
Restoring governor userspace for cpu 0
CPU 1 already managed, adding link
CPU 2 already managed, adding link
CPU 3 already managed, adding link
setting new policy for CPU 0: 198000 - 996000 kHz
new min and max freqs are 198000 - 996000 kHz
governor switch
__cpufreq_governor for CPU 0, event 1
governor: change or update limits
__cpufreq_governor for CPU 0, event 3
target for CPU 0: 792000 kHz, relation 0
initialization complete
unregistering CPU 2
removing link
unregistering CPU 3
removing link


Thanks
Richard
