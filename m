From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 17 Dec 2014 22:16:09 +0900
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <4583974.6IftQ5bv2t@wuerfel>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1628217.66frkAqHMc@wuerfel>
 <CAAVeFuJhiten-eVLCa2sMG-nsRwjPMiZap8UJM1kNCuRyK-b1w@mail.gmail.com>
 <4583974.6IftQ5bv2t@wuerfel>
Message-ID: <CAAVeFu+CG82UBgsQ4+RNqitUmxxaKi0P50=fjpKCqo0_ODO3jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 7:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 17 December 2014 11:45:01 Alexandre Courbot wrote:
>>
>> Actually we are not that far from being able to do completely without
>> any GPIO number, and maybe that's what we should aim for. I think the
>> only remaining offender is the sysfs interface. If we could reach GPIO
>> controllers through a fixed path and just export their GPIOs there, I
>> believe we would have fixed the whole issue.
>
> What about the hundreds of board files and device drivers that still
> reference hardcoded gpio numbers? The problem seems mostly solved for
> anything that uses DT, but there are some architectures and a number
> of ARM platforms that don't use DT and probably never will.
>
> I would assume they could all be changed to use gpiod_lookup tables,
> but that's a lot of work.

Indeed, that's not something to expect, as I replied to Russell. Sorry
about the confusion.
