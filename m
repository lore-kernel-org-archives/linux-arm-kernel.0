From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 11:26:40 +0100
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <CAAVeFuJhiten-eVLCa2sMG-nsRwjPMiZap8UJM1kNCuRyK-b1w@mail.gmail.com>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1628217.66frkAqHMc@wuerfel>
 <CAAVeFuJhiten-eVLCa2sMG-nsRwjPMiZap8UJM1kNCuRyK-b1w@mail.gmail.com>
Message-ID: <4583974.6IftQ5bv2t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 11:45:01 Alexandre Courbot wrote:
> 
> Actually we are not that far from being able to do completely without
> any GPIO number, and maybe that's what we should aim for. I think the
> only remaining offender is the sysfs interface. If we could reach GPIO
> controllers through a fixed path and just export their GPIOs there, I
> believe we would have fixed the whole issue.

What about the hundreds of board files and device drivers that still
reference hardcoded gpio numbers? The problem seems mostly solved for
anything that uses DT, but there are some architectures and a number
of ARM platforms that don't use DT and probably never will.

I would assume they could all be changed to use gpiod_lookup tables,
but that's a lot of work.

	Arnd
