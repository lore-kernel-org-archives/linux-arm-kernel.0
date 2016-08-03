From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 3 Aug 2016 15:46:29 -0600
Subject: [PATCH V3 4/6] perf tools: pushing driver configuration down to
 the kernel
In-Reply-To: <20160731120310.GB12673@krava>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-5-git-send-email-mathieu.poirier@linaro.org>
 <20160731120310.GB12673@krava>
Message-ID: <CANLsYkxAVU7yX-a0mUGxC0EtLZUpORPSpbgHeUPo99JOFRu2xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2016 at 06:03, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Jul 28, 2016 at 03:42:21PM -0600, Mathieu Poirier wrote:
>> Now that PMU specific driver configuration are queued in
>> evsel::config_terms, all we need to do is re-use the current
>> ioctl() mechanism to push down the information to the kernel
>> driver.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  tools/perf/builtin-record.c |  9 +++++++++
>>  tools/perf/builtin-stat.c   |  8 ++++++++
>
> how about perf top?

It took me a while to notice the "event" option in cmd_top().  You are
correct, it applies there as well.

Mathieu

>
> jirka
