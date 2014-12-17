From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 17 Dec 2014 22:13:26 +0900
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <20141217104428.GV11285@n2100.arm.linux.org.uk>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1918116.UxUgDPTmcq@wuerfel>
 <CAAVeFuL2MKRA7YLm_wsyftNy-sxgEYPrmqBm8XTRZQb66YF-qw@mail.gmail.com>
 <1628217.66frkAqHMc@wuerfel>
 <CAAVeFuJhiten-eVLCa2sMG-nsRwjPMiZap8UJM1kNCuRyK-b1w@mail.gmail.com>
 <20141217104428.GV11285@n2100.arm.linux.org.uk>
Message-ID: <CAAVeFuL1QEaFMkC1qQ42EEWU_=_KCyO=_waq-7eshPrVY58m0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 7:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 17, 2014 at 11:45:01AM +0900, Alexandre Courbot wrote:
>> Actually we are not that far from being able to do completely without
>> any GPIO number, and maybe that's what we should aim for. I think the
>> only remaining offender is the sysfs interface.
>
> And that is a user API, and there's lots of users of it (eg, on Raspberry
> Pi platforms.)  So changing it isn't going to be easy - I'd say that it's
> impractical.
>
> What you're suggesting would be like re-numbering Linux syscalls.

Uh, I expressed myself poorly. What I intended to say is that once we
have a sysfs alternative that does not rely on GPIO numbers (and thus
have the same feature coverage as the integer interface), we can
require new platforms to exclusively rely on gpiod/sysfs2, and
encourage older users to switch to it if they have an issue with the
way integers are handled or need one of the new features.

I don't foresee that we will ever be able to retire the integer
interface, however I would like to be able to say "your problem will
be solved if you switch to gpiod" instead of having to juggle with
potentially conflicting integer range requirements from different
platforms. Right now the only thing that prevents us to say that is
the lack of a consistent sysfs interface.
