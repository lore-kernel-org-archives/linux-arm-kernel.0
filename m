From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 2 Jul 2018 07:57:27 -0700
Subject: [PATCH v5 10/10] perf probe: Support SDT markers having
 reference counter (semaphore)
In-Reply-To: <20180628052209.13056-11-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-11-ravi.bangoria@linux.ibm.com>
Message-ID: <20180702145727.GC65296@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-06-28 10:52:09]:

> With this, perf buildid-cache will save SDT markers with reference
> counter in probe cache. Perf probe will be able to probe markers
> having reference counter. Ex,
> 
>   # readelf -n /tmp/tick | grep -A1 loop2
>     Name: loop2
>     ... Semaphore: 0x0000000010020036
> 
>   # ./perf buildid-cache --add /tmp/tick

Would this perf buildid-cache work if the executable is stripped of
symbols?

>   # ./perf probe sdt_tick:loop2
>   # ./perf stat -e sdt_tick:loop2 /tmp/tick
>     hi: 0
>     hi: 1
>     hi: 2
>     ^C
>      Performance counter stats for '/tmp/tick':
>                  3      sdt_tick:loop2
>        2.561851452 seconds time elapsed

Also can we document how to use SDT markers with perf under perf-probe
or perf-build-cache?
