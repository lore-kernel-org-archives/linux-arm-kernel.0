From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Thu, 18 Jul 2013 16:25:27 +0200
Subject: [PATCH v3] clk: add MOXA ART SoCs clock driver
In-Reply-To: <20130718135650.GD29153@e106331-lin.cambridge.arm.com>
References: <1372943292-6960-1-git-send-email-jonas.jensen@gmail.com>
 <1374067396-30155-1-git-send-email-jonas.jensen@gmail.com>
 <20130718095035.GA29153@e106331-lin.cambridge.arm.com>
 <CACmBeS2SnpiUtiQD6j9qyaXZ5-chHSHVeo4c5=UhitVonvkKtw@mail.gmail.com>
 <20130718110201.GB29153@e106331-lin.cambridge.arm.com>
 <CACmBeS24smrJ4SLY7snv1_6SRcuXRkZ8t0PGMvBupUpKMMb43w@mail.gmail.com>
 <20130718135650.GD29153@e106331-lin.cambridge.arm.com>
Message-ID: <CACmBeS2rBTtyfzUgB41zXkDC5-DRcvArgeyjbqHQHXO5+QLvmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2013 15:56, Mark Rutland <mark.rutland@arm.com> wrote:
> When you say look up the apb-clock node, I assume they find it via their
> clocks property with of_clk_get or similar, rather than scanning the
> tree for a "moxart,moxa-apb-clock" node specifically?

Yes, all use of_clk_get(node, 0), which is fortunate because e.g.
clocksource is already merged with linaro's clockevent drivers tree.

That should mean I can get away with only changing the DT files :)

> Given the above, I think it would make more sense to have core-clock
> registered, and have it passed to the devices currently passed
> apb-clock.

OK, I'll return with an updated version.


Best regards,
Jonas
