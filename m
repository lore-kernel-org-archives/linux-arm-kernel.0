From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 15 Feb 2016 18:32:00 -0700
Subject: [PATCH] coresight: etb: Remove simple announcement message
In-Reply-To: <20160212215428.GB18988@sirena.org.uk>
References: <1455195004-30214-1-git-send-email-broonie@kernel.org>
 <CANLsYkwVn4FgBST-0MeOa38qCkH78-z32_CXewcCF78CnvbxeQ@mail.gmail.com>
 <20160212215428.GB18988@sirena.org.uk>
Message-ID: <CANLsYkxergpAc2Qu8Uq9JF0s9_xtSWhBfCZ0-fH69nVFjEY9Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2016 at 14:54, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Feb 12, 2016 at 01:44:31PM -0700, Mathieu Poirier wrote:
>> On 11 February 2016 at 05:50, Mark Brown <broonie@kernel.org> wrote:
>
>> > -       dev_info(dev, "ETB initialized\n");
>> >         return 0;
>
>> Didn't we touch base on that topic before?  I'm not against moving
>
> We did and you said that there was a patch pending which would change it
> to print something useful but the patch still applies so I guess that
> didn't happen.
>
>> forward with this but it has to be all or nothing - whether we remove
>> all the CS boot log message or they all stay.  Otherwise people could
>> mistakenly come to the conclusion that some of the CS components did
>> not boot properly.
>
>> ETB, funnel and TMCs don't output any useful HW related information
>> but tracers (ETMv3, PTM and ETMv4) actually do.
>
> I think people are familiar enough with the general policy on this stuff
> to be able to cope with this, it's certainly not something that's ever
> come up with ASoC where we do have a similar multi-device structure.

Ok - please send me another patch that removes the boot log messages
for  the TMC, funnel and TPIU drivers.  That way only the tracers
(ETMv3/4) get to keep their boot logs.

Thanks,
Mathieu

>
>> People concerned about boot time will definitely set their loglevel
>> accordingly on the kernel cmd line.  Otherwise we are likely talking
>> about developers interested in knowing what happened when their kernel
>> booted.
>
> That applies equally to all drivers so from that point of view we should
> be doing something in the driver core - there is actually some logging
> there that can be enabled, though it's not that widely used.
