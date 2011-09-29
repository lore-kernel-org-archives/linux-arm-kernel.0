From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 30 Sep 2011 07:21:00 +0800
Subject: [PATCH] PM: HIBERNATION: add resume_wait param to support
	MMC-like devices as resume file
In-Reply-To: <CAKPcRGpPG2Z_tMQFHz8fpBLhLO4dx58AVhYWmPdZ_0pV7pVK6A@mail.gmail.com>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
	<CAKPcRGr3EzjS2es6HniuQziEivpsfH2r=d_Y=nkrsFW59g6xSw@mail.gmail.com>
	<CAKPcRGpPG2Z_tMQFHz8fpBLhLO4dx58AVhYWmPdZ_0pV7pVK6A@mail.gmail.com>
Message-ID: <CAGsJ_4x=tC3sVdXbsN_U-xc6CH5AVqOJEjY0a3h1SuH6Xobpiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/29 Luca Tettamanti <kronos.it@gmail.com>:
> On Thu, Sep 29, 2011 at 5:47 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> On Thu, Sep 29, 2011 at 11:29 AM, Barry Song <Barry.Song@csr.com> wrote:
>>> From: Barry Song <baohua.song@csr.com>
>>>
>>> Some devices like mmc are async detected very slow. For example,
>>> drivers/mmc/host/sdhci.c launchs a 200ms delayed work to detect
>>> mmc partitions then add disk.
>>>
>>> we do have wait_for_device_probe and scsi_complete_async_scans
>>> before calling swsusp_check, but it is not enough to wait mmc.
>>>
>>> This patch adds resumewait kernel param just like rootwait so
>>> that we have enough time to wait mmc ready. The differene is
>>> here we wait for resume partition but rootwait waits for rootfs
>>> partition.
>>
>> I assume that such a device would need "rootwait" to boot in the first
>> place; why don't you "overload" the param to also enable waiting in
>> the resume path?
>
> And in case that makes sense, it might be worthwhile to refactor a
> common helper to be also used in do_mounts.c, e.g.
> dev_t wait_for_device(char *name)

it is ok until we have many cases which wait for devices by polling.
but there are only two by the moment.
here i don't see it is worthwhile since the current codes are short
and clear enough.

>
> L

-barry
