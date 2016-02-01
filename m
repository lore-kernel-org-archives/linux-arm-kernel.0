From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 01 Feb 2016 17:19:16 +0100
Subject: weird RCU problem with 4.4.0
Message-ID: <87d1sgl7y3.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

in the dmesg log (actually "journalctl -f") of one of my machines I had this:

...
03:25:01 CRON[16607]: pam_unix(cron:session): session closed for user root
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=301
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=301
    (detected by 0, t=303 jiffies, g=2533688, c=2533687, q=4860)
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=1204
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=1205
    (detected by 0, t=1208 jiffies, g=2533688, c=2533687, q=19822)
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=2109
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=2109
    (detected by 0, t=2113 jiffies, g=2533688, c=2533687, q=34248)
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=3011
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=3011
    (detected by 0, t=3018 jiffies, g=2533688, c=2533687, q=48662)
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=3912
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=3912
    (detected by 0, t=3923 jiffies, g=2533688, c=2533687, q=63080)
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=4815
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=4815
    (detected by 0, t=4828 jiffies, g=2533688, c=2533687, q=68037)
...
and so on, and so forth ...
...
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=137745
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=137746
    (detected by 0, t=137863 jiffies, g=2533688, c=2533687, q=68849)
INFO: rcu_preempt detected stalls on CPUs/tasks:
    1-...: (1 GPs behind) idle=763/140000000000000/0 softirq=6109762/6109762 fqs=138651
    2-...: (1 GPs behind) idle=2f3/140000000000000/0 softirq=5129036/5129037 fqs=138652
