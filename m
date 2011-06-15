From: peter.fordham@gmail.com (Peter Fordham)
Date: Wed, 15 Jun 2011 11:57:12 -0700
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <20110615085820.GH3075@pulham.picochip.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<20110614234858.GA15534@gallagher>
	<BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com>
	<20110615085820.GH3075@pulham.picochip.com>
Message-ID: <BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I've added Wim (watchdog driver maintainer), but I would think that if
> this change is worth doing then it should be done for all drivers.

Agreed, but today this may be more work than I'm strictly interested in
doing. If we do decide it's the right thing then I'll look into converting the
other drivers later.

>> > I believe the sysfs classes are pretty much
>> > deprecated now in preference of a bus too.
>>
>> Can you give me some more info here? I thought the sysfs stuff was the
>> new right way of doing stuff. The class stuff allows udev to automatically
>> create the right device node.
>
> So here's one that I'm aware of https://lkml.org/lkml/2011/3/25/502. ?So
> there's nothing wrong with using sysfs and a bus, but certainly a bus is
> preferred over a class.

I still don't really get this. If I don't use the class code my /dev node gets
the name /dev/mpcore_wdt instaed of /dev/watchdog. Is the right thing
to do to use a udev rule or is there a way to tell udev via sysfs to make
/dev/watchdog instead of /dev/mpcore_wdt?

Pete
