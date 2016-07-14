From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Thu, 14 Jul 2016 10:54:45 -0700
Subject: [PATCH v9 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <1468518428.8745.43.camel@perches.com>
References: <1468517266-1642-1-git-send-email-ttnguyen@apm.com>
 <1468517266-1642-4-git-send-email-ttnguyen@apm.com>
 <1468518428.8745.43.camel@perches.com>
Message-ID: <CACgAJHwzWG_6iWG4OcL3v5QcUF892DwBcJxayqbH4f2kd7=kQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Thu, Jul 14, 2016 at 10:47 AM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2016-07-14 at 10:27 -0700, Tai Nguyen wrote:
>> This patch adds a driver for the SoC-wide (AKA uncore) PMU hardware
>> found in APM X-Gene SoCs.
>
> trivia:
>
>> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> []
>> +struct xgene_pmu_dev_ctx {
>> +     char *name;
>> +     struct list_head next;
>> +     struct xgene_pmu_dev *pmu_dev;
>> +     struct hw_pmu_info inf;
>> +};
>
> Probably better to use something like
>         char    name[20];
> as the kasprintf can fail and this doesn't
> seem to be freed anywhere.

Okay. I'll fix it shortly.

[...]

Thanks,
-- 
Tai
