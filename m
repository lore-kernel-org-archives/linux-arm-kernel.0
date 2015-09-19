From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 19 Sep 2015 12:09:34 +0200
Subject: [RFC PATCH 20/20] coresight: updating documentation to reflect
 integration with perf
In-Reply-To: <1442593594-10665-21-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-21-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20150919100934.GA31274@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Looks like a pretty useful feature all around. While reading the description I 
noticed a few typos:

* Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> +Regardless of the amnout ETM/PTM IP block in a system (usually equal to the
> +amount of processor core), the "cs_etm" PMU will be listed only once.

s/amnout/amount

> +Tracing limited to user and kernel space can also be used to narrow the amount
> +of collected tracers:

s/tracers/traces

> +The Coresight PMUs can be configured to work in "full trace" or "snapshot" mode.
> +In full trace mode trade acquisition is enable from beginning to end with trace
> +data being recorded continuously:

s/trade acquisition/trace acquisition
s/is enable from/is enabled from

> +Since this can lead to a significant amount of data and that some device are
> +limited in disk space snapshot mode can be used instead.

s/and that some device are limited in disk space/
  and because some devices are limited in disk space

> +Trace data collected during trace runs end up in the centennial "perf.data"
> +file.

hey, perf isn't 100 years old! :-)

s/centennial/central ?

Also, 'data' is singular in this context, so I think:

s/data collected during trace runs end up in the
 /data collected during trace runs ends up in the


> [...] Trace configuration information necessary for trace decoding are also
> +embedded in the "perf.data" file.

s/are/is

>  Two new headers, 'PERF_RECORD_AUXTRACE_INFO'
> +and 'PERF_RECORD_AUXTRACE' have been added to list of event types in order to
> +find out where the different sections start.

s/to list of event types
 /to the list of event types

> +
> +It is worth nothing that a set of metadata information exists for each tracer
> +that participated in a trace run. [...]

s/nothing
 /noting

  As such if 5 processors have been engaged,
> +5 set of metadata will be found in the perf.data file.

s/5 set of metadata
 /5 sets of metadata

> +Metadata information is collected directly from the ETM/PTM management registers
> +using the sysFS interface.  Since there is not way for the perf command line
> +tool to associate a CPU with a tracer, a symbolic link has been created between
> +the cs_etm sysFS event directory and each Coresight tracer:

s/there is not way
 /there is no way

> +As with the perf method described above, a coresight sink needs to be identify
> +before trace collection can commence.

Btw., 'Coresight' is spelled in two different ways throughout this document: 
capitalized and non-capitalized. Please pick one variant and use it consistently.

>  any given moment.  As a generic operation, all device pertaining to the sink
> -class will have an "active" entry in sysfs:

s/all device pertaining to
 /all devices pertaining to

Thanks,

	Ingo
