From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 12 Feb 2015 11:09:50 +0200
Subject: [PATCH v3 2/2] remoteproc: add support to handle internal memories
In-Reply-To: <20150211205757.GI2531@atomide.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com>
 <1420838519-15669-3-git-send-email-s-anna@ti.com>
 <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com>
 <20150211205757.GI2531@atomide.com>
Message-ID: <CAK=WgbbFxNfn5tUeJn-8NehFXAD+=7UW-WtBf3ZFm1xyomFAfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 10:57 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > +static int rproc_handle_intmem(struct rproc *rproc, struct fw_rsc_intmem *rsc,
>> > +                              int offset, int avail)
>> > +{
>> ...
>> > +       va = (__force void *)ioremap_nocache(rsc->pa, rsc->len);
>>
>> Back in the days when we developed remoteproc there was a tremendous
>> effort to move away from ioremap when not strictly needed.
>
> The use of ioremap in general is just fine for drivers as long
> as they access a dedicated area to the specific device. Accessing
> random registers and memory in the SoC is what I'm worried about.

Yes, the proposed interface essentially allows exactly this random
access, since the parameters to ioremap would be provided from the
user space (specifically from the resource table contained within the
firmware of the remote processor).

Thanks,
Ohad.
