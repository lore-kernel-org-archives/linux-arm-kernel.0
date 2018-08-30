From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 30 Aug 2018 14:45:31 -0400
Subject: [PATCH v9 4/4] perf probe: Support SDT markers having reference
 counter (semaphore)
In-Reply-To: <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
Message-ID: <20180830144531.3011e185@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Arnaldo,

I'm going to be playing with some of the probe code which may conflict
with these patches, so I would like to pull these in my tree. But this
patch requires an Acked-by from you before I can pull it in.

You OK with this?

Thanks!

-- Steve


On Mon, 20 Aug 2018 10:12:50 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> With this, perf buildid-cache will save SDT markers with reference
> counter in probe cache. Perf probe will be able to probe markers
> having reference counter. Ex,
> 
>   # readelf -n /tmp/tick | grep -A1 loop2
>     Name: loop2
>     ... Semaphore: 0x0000000010020036
> 
>   # ./perf buildid-cache --add /tmp/tick
>   # ./perf probe sdt_tick:loop2
>   # ./perf stat -e sdt_tick:loop2 /tmp/tick
>     hi: 0
>     hi: 1
>     hi: 2
>     ^C
>      Performance counter stats for '/tmp/tick':
>                  3      sdt_tick:loop2
>        2.561851452 seconds time elapsed
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
