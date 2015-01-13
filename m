From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 09:06:15 +0100
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <20141217104428.GV11285@n2100.arm.linux.org.uk>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1918116.UxUgDPTmcq@wuerfel>
 <CAAVeFuL2MKRA7YLm_wsyftNy-sxgEYPrmqBm8XTRZQb66YF-qw@mail.gmail.com>
 <1628217.66frkAqHMc@wuerfel>
 <CAAVeFuJhiten-eVLCa2sMG-nsRwjPMiZap8UJM1kNCuRyK-b1w@mail.gmail.com>
 <20141217104428.GV11285@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZbGjNecrggrFr_18zjobXMBpkrSjBMAUfyfs2ZCebB0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 11:44 AM, Russell King - ARM Linux
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

The problem is that right now if we set the .base of a gpio_chip
to -1 for dynamic allocation of GPIO numbers and we have more
than one GPIO chip in the system, the numbers basically depend
on probe order, and may theoretically even differ between two boots.

So in these cases preserving the ABI means preserving the
unpredictability of these assigned numbers or something.

For the old usecases with a single GPIO controller and a fixed
base offset of e.g. 0 (which I suspect was implicit in the initial
design of the subsystem) things work fine as always, it's these new
dynamic use cases that destabilize the ABI.

Yours,
Linus Walleij
