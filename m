From: venkatesh.vivekanandan@broadcom.com (Venkatesh Vivekanandan)
Date: Mon, 3 Oct 2016 17:06:15 +0530
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
Message-ID: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am trying to collect ETF trace from Juno R1 and could see "cpu
stall" while dumping the trace. Attached is the log of sequence
followed. Was trying to collect the trace data from hardware and see
if it is any valid data. Am I missing anything here?.

cenaro-test [rc=0]# echo 0 > /sys/bus/coresight/devices/22140000.etm/enable_sour
[   89.609083] coresight-etm4x 22140000.etm: ETM tracing disabled
[   89.614892] coresight-funnel 220c0000.cluster0-funnel: FUNNEL
inport 1 disabled
[   89.622140] coresight-funnel 20040000.main-funnel: FUNNEL inport 0 disabled
[   89.629057] coresight-tmc 20010000.etf: TMC-ETB/ETF disabled
linaro-test [rc=0]# dd if=/dev/20010000.etf of=/cstrace.bin bs=1
[  128.876846] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  128.882457]  3-...: (65 GPs behind) idle=a3f/140000000000000/0
softirq=314/315 fqs=2288
[  128.890462]  (detected by 1, t=5252 jiffies, g=0, c=-1, q=19)
[  128.896151] Task dump for CPU 3:
[  128.899340] dd              R  running task        0  1237   1234 0x00000002
[  128.906322] Call trace:
[  128.908745] [<ffff000008085560>] __switch_to+0xc8/0xd4
[  128.913826] [<0000000000020000>] 0x20000

This happens consistently with every boot.

Thanks,
Venkatesh.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: r1-trace-log
Type: application/octet-stream
Size: 4121 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161003/34981cfd/attachment-0001.obj>
