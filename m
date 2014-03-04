From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 4 Mar 2014 12:58:18 +0100
Subject: [PATCH 0/3] perf tools: Add libdw DWARF post unwind support for
 ARM
In-Reply-To: <CAFrcx1mg03A+e7q2d1HR=bR7uoDw5k36TVw5TQP68caWYBNJnQ@mail.gmail.com>
References: <1393840403-26639-1-git-send-email-jean.pihet@linaro.org>
 <CAFrcx1mg03A+e7q2d1HR=bR7uoDw5k36TVw5TQP68caWYBNJnQ@mail.gmail.com>
Message-ID: <20140304115756.GC1119@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 02:24:37AM +0100, Jean Pihet wrote:
> Hi,
> 
> Here are some notes about the performance improvement and the test usage.
> 
> Jiri, do you need these notes in the one of commit description?
> 
> 1. Using libdw vs libunwind on ARMv7
> 
> The performance gain is (more than) significant: >800%.
> 
> I did not profile perf itself ;-p just did a timing measurement.
> The benchmark has been run multiple times with different perf.data
> sizes. The results are consistent across the tests runs.
> 
> Usage:
> ./tools/perf/perf record --call-graph dwarf --
> ../../libunwind/test_app/stress_bt
> time ./tools/perf/perf report --stdio > /dev/null 2>&1
> 
> Platform:
> Quad-core marvell XP370. perf runs on 1 cpu
> 
> Perf data size:
> 304MB    libunwind    libdw        improvement
> real    9m31.577s    1m13.052s    782%
> user    5m33.020s    1m2.910s    529%
> sys        3m57.770s    0m10.090s    2356%
> 
> 2. unwind test usage
> perf test list gives the list of supported tests. In this case the
> test #23 is dwarf unwinding:
> 
> ./tools/perf/perf test 23
> 23: Test dwarf unwind                                      : Ok
> 
> 
> Regards,
> Jean
> 
> 

I can't speak for the arm specific stuff, but generally it fits
and looks ok (and does not break the x86 build)

also.. who wouldn't ack 800% speed improvement ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
