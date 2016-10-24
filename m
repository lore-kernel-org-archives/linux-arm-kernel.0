From: cyberlab@gmx.de (Jost Menke)
Date: Mon, 24 Oct 2016 17:09:21 +0200
Subject: 4.9 RC2 fails to boot on mk802ii with generic DT based cpufreq driver
Message-ID: <trinity-cf616e2b-d3f0-4edf-b53b-0c69e7e74795-1477321761683@3capp-gmx-bs51>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I ran into a problem with the recent mainline kernel on my Allwinner A10 based MK802ii. It looks like a wrong initial CPU frequency is chosen. It will boot until this point:

[3.040447] cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 384000 KHz
[3.057932] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 624000 KHz

After that, it just freezes. When I compile with a different cpufreq driver, it will boot up but there doesn't seem to be any frequency scaling (/sys/devices/system/cpu/cpu0/cpufreq is empty) and I think it just remains at a very low clock speed because sysbench results are really slow.

Any ideas?

Cheers
Jost
