From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 23 Dec 2015 09:29:43 -0700
Subject: [PATCH V7 00/24] Coresight integration with perf
In-Reply-To: <20151219174231.GD2437@debian>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <20151219174231.GD2437@debian>
Message-ID: <CANLsYkw7X_B7EKj=_zOXZugAztsPZf2cmPLQXbj37dByMrqA2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 December 2015 at 10:42, Rabin Vincent <rabin@rab.in> wrote:
> On Fri, Dec 18, 2015 at 01:58:56PM -0700, Mathieu Poirier wrote:
>> This patchset aims to integrate configuration and control of
>> the Coresight tracers with the perf sub-system.
>>
>> The goal is to use PMUs to represent tracers and the auxiliary
>> buffer enhancement to collect processor traces.  As such a lot
>> of work is done to move the current Coresight sysFS oriented
>> configuration and control commands to perf's AUX API.
>
> These patches allow the trace to be recorded with perf, but what do you
> use to actually get something useful out of the resulting perf.data?
> AFAICS it can't be processed by perf script or the other perf tools.

You are correct.  The team is working on a trace decoder that will be
embedded in the perf tool suite.

>
> # echo 1 > /sys/bus/coresight/devices/54162000.etb/enable_sink
>
> # perf record -e cs_etm// true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.032 MB perf.data ]
>
> # perf script
> 0x188 [0x80]: failed to process type: 70
