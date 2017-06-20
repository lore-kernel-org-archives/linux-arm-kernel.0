From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 21 Jun 2017 00:08:05 +0200
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
 <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net>
 <20170620132620.GA16881@amd>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
 <20170620134458.GA10104@amd>
 <20170620134827.ubvzhh25klaotupv@piout.net>
 <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
Message-ID: <20170620220805.GA11195@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> > This is it.
> >> > https://patchwork.kernel.org/patch/6219401/
> >>
> >> Thanks.
> >>
> >> Yes, that's argument against changing rtc _drivers_ for hardware that
> >> can not do better than 32bit. For generic code (such as 44/51 sysfs,
> >> 51/51 suspend test), the change still makes sense.
> 
> What I had in mind when writing those patches was to remove the limitations
> coming from those functions usage, even more since they been marked has
> deprecated.
> 
> I agree that will change nothing of hardware limitation but at least
> the limit will
> not come from the framework.

> > Yes, we agree on that but I won't cherry pick working patches from a 51
> > patches series.

Well, it would be actually nice for you to do the cherry
picking. That's something maintainers do, because it is hard for
contributors to guess maintainer's taste.

Anyway, it looks like someone should go through all the RTC drivers,
and document their limitations of each driver (date in future when
hardware ceases to be useful). If Benjamin has time to do that, I
guess that removes all the objections to the series.

Regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/9ea489d7/attachment-0001.sig>
