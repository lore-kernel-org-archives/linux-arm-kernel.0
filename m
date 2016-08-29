From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 29 Aug 2016 09:57:27 -0600
Subject: [PATCH V6 5/5] perf tools: adding sink configuration for cs_etm
 PMU
In-Reply-To: <20160828141616.GB32293@krava>
References: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
 <1472156445-24283-6-git-send-email-mathieu.poirier@linaro.org>
 <20160828141616.GB32293@krava>
Message-ID: <CANLsYkwJJW3jTk6xUZ2YnW4L4j1Phqgi_UNAxRTygRERSMCiUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2016 at 08:16, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Aug 25, 2016 at 02:20:45PM -0600, Mathieu Poirier wrote:
>
> SNIP
>
>>       return NULL;
>>  }
>> +
>> +static FILE *cs_device__open_file(const char *name)
>> +{
>> +     struct stat st;
>> +     char path[PATH_MAX];
>> +     const char *sysfs;
>> +
>> +     sysfs = sysfs__mountpoint();
>> +     if (!sysfs)
>> +             return NULL;
>> +
>> +     snprintf(path, PATH_MAX,
>> +              "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
>> +
>> +     printf("path: %s\n", path);
>
> should this be pr_info ?

That's a debug message that slipped through - it shouldn't be there at all.

>
> jirka
