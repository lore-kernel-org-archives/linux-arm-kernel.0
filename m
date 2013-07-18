From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Thu, 18 Jul 2013 12:36:40 +0200
Subject: [PATCH v3] clk: add MOXA ART SoCs clock driver
In-Reply-To: <20130718095035.GA29153@e106331-lin.cambridge.arm.com>
References: <1372943292-6960-1-git-send-email-jonas.jensen@gmail.com>
 <1374067396-30155-1-git-send-email-jonas.jensen@gmail.com>
 <20130718095035.GA29153@e106331-lin.cambridge.arm.com>
Message-ID: <CACmBeS2SnpiUtiQD6j9qyaXZ5-chHSHVeo4c5=UhitVonvkKtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, thanks for taking a look at this.

On 18 July 2013 11:50, Mark Rutland <mark.rutland@arm.com> wrote:
> This confuses me. moxart_of_clk_init gets called because there was a
> "moxa,moxart-core-clock", node in the dt, but the driver only seems to
> use the information to figure out the configuration of another clock
> ("moxa,moxart-apb-clock"), and never registers a clock specifically for
> the core-clock.
>
> I couldn't find "moxa,moxart-apb-clock" described in mainline. COuld you
> describe the relationship between core-clock and apb-clock?

It's true core-clock exist only so the register can be mapped.

apb-clock is part of a patch set that will add new device tree files for the
MOXA ART SoC, but it's not in mainline:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181757.html

apb-clock could be a fixed rate 48MHz DT only clock, but because we can't
be sure it's 48MHz on all platforms, reading it from a register with core-clock
is more portable.


Best regards,
Jonas
