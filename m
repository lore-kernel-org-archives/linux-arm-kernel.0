From: joel.opensrc@gmail.com (Joel Fernandes)
Date: Wed, 1 Mar 2017 16:42:17 -0800
Subject: ARM64 perf stacktraces on tracepoint events
Message-ID: <CAEi0qNm3NKSWQOD6A2Z0NTNEfp1kLNEZz-=y+dbVCwYMP0HFoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 3.18 kernel running on an arm64 device, I tried running:
perf record -a -g -e sched:sched_wakeup

I was expecting something like the output at:
www.brendangregg.com/perf.html

But I don't see stacktraces, could I be missing any patches you could
point me to? I do see stack traces if I do regular perf profiling
(perf record -F 99 -a -g).

Below is the output I get. Thanks for any insight into this.

Regards,
Joel

sailfish:/data # ./perf report
       # Samples: 22  of event 'sched:sched_wakeup'
# Event count (approx.): 410333
#
# Children      Self  Trace output
# ........  ........
.............................................................
#
    61.29%    61.29%  comm=ksoftirqd/0 pid=3 prio=120 success=1 target_cpu=000
            |
            ---0

    33.25%    33.25%  comm=hw pid=12777 prio=120 success=1 target_cpu=002
            |
            ---0

     2.46%     2.46%  comm=kworker/u8:2 pid=12482 prio=120 success=1
target_cpu=002
            |
            ---0

     1.39%     1.39%  comm=migration/2 pid=21 prio=0 success=1 target_cpu=002
            |
            ---0
