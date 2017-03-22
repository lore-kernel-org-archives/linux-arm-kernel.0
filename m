From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 15:59:29 +0000
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <CAFpQJXXqU6pvjckrQ86jXPhKd9XZQ+hDHt8X19Wy31JmLJvrjw@mail.gmail.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <58CA8C8A.8080405@huawei.com>
 <CAFpQJXVe_=42R+0Ch-tLwCcvhX3xJa20mhgYCWWNty-sn1Gp+g@mail.gmail.com>
 <CAFpQJXXqU6pvjckrQ86jXPhKd9XZQ+hDHt8X19Wy31JmLJvrjw@mail.gmail.com>
Message-ID: <20170322155929.GA19950@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 02:46:50PM +0530, Ganapatrao Kulkarni wrote:
> i am not able to run with latest perf tool, i see issue with memory
> corruption in malloc
> is this seen from anyone else too?
> i am not sure, is this issue with my setup?
> 
> root at VAL1-13>perf>> perf stat -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>             10,815      armv8_pmuv3_0/br_mis_pred/
> 
>        1.001232167 seconds time elapsed
> 
> root at VAL1-13>perf>> ./perf stat -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> *** Error in `./perf': free(): invalid next size (fast): 0x00000000086a7a00 ***
> Aborted (core dumped)
> root at VAL1-13>perf>> ./perf -v
> perf version 4.11.rc3.g093b99
> root at VAL1-13>perf>> perf -v
> perf version 4.8.rc6.g21c488
> root at VAL1-13>perf>> uname -a
> Linux VAL1-13 4.11.0-rc2-12139-g3804e12 #1 SMP PREEMPT Wed Mar 22
> 06:26:28 UTC 2017 aarch64 aarch64 aarch64 GNU/Linux
> root at VAL1-13>perf>>

I've managed to reproduce this on a Seatle system using DT, with the
perf tool from v4.11-rc3.

I'm digging into this now.

Thanks,
Mark.
