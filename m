From: lho@apm.com (Loc Ho)
Date: Wed, 29 Jul 2015 22:31:49 -0700
Subject: [PATCH v2 2/3] edac: Add L3/SoC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <20150730043148.GC7209@nazgul.tnic>
References: <1437808063-17592-1-git-send-email-lho@apm.com>
 <1437808063-17592-2-git-send-email-lho@apm.com>
 <1437808063-17592-3-git-send-email-lho@apm.com>
 <20150729142941.GC17367@nazgul.tnic>
 <CAPw-ZTkZ7q8PUWydFad5TXrhcY6YBRjdVvz+SR+LV4sOLDKkEg@mail.gmail.com>
 <20150730043148.GC7209@nazgul.tnic>
Message-ID: <CAPw-ZTnipyRLnRxNTvq6FJTHyt2EbhObJMOa542LYOGna3FgjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> Debug folder node shows up at /sys/kernel/debug/<file here> while the
>> MC debug node shows up at /sys/kernel/debug/edac where <file here> is
>> the driver node name. It would be better if everything shows up at
>> /sys/kernel/debug/edac. For this to happen, I need EDAC core change to
>> provide an parent node.
>
> Sure, feel free to add accessors for edac_debugfs from
> drivers/edac/edac_mc_sysfs.c which edac drivers can call and thus
> receive the top-level debugfs node.

Okay...

>
> For that, you can put all those accessor prototypes into a
> drivers/edac/edac-internal.h header which should be included only by
> edac drivers.
>
>> No... each EDAC instance has its own context as we allocated via
>> function edac_device_alloc_ctl_info. Per type of instance will use the
>> same type function.
>
> So you have multiple instances running on the system? I don't think
> anyone has audited the edac core and whether it can actually handle
> that...

Let me clarify a bit. I have one top level driver node and multiple
instance of subnodes -  4 MC, 4 L2/L1, 1 L3C, and 1 SoC EDAC for now.
The L3C many be multiple instance in the future. Just a note,  the way
EDAC looks up instance is by pointer of struct device. It doesn't need
anything more than that.

-Loc
