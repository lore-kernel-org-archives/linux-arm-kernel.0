From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Feb 2011 19:21:09 -0000
Subject: [PATCH 3/5] ARM: tegra: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <AANLkTimYvHOzv2w_oxOB5HJfMhp8Kg_A0-Y7Mj41M-HX@mail.gmail.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>	<1298302096-21275-4-git-send-email-will.deacon@arm.com>
	<AANLkTimYvHOzv2w_oxOB5HJfMhp8Kg_A0-Y7Mj41M-HX@mail.gmail.com>
Message-ID: <001d01cbd2c5$a97f17a0$fc7d46e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

> On Mon, Feb 21, 2011 at 7:28 AM, Will Deacon <will.deacon@arm.com> wrote:
> > The chained GPIO IRQ handler on Tegra calls ->irq_ack on the parent
> > chip prior to handling the interrupt.
> >
> > This patch updates the code to use ->irq_eoi now that the GIC has moved
> > to using the fasteoi flow model.
> >
> > Cc: Colin Cross <ccross@google.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mach-tegra/gpio.c |   17 +----------------
> >  1 files changed, 1 insertions(+), 16 deletions(-)

[...]

> Acked-by: Colin Cross <ccross@android.com>

Thanks Colin.

> Works with chained gpio handlers on Tegra, although the patch is
> filled with = escaping.

Hmm, I've seen this problem before. See Russell's explanation here:

http://lists.arm.linux.org.uk/lurker/message/20101201.172105.938cf2c5.en.html

I don't believe it's a problem my end, but if it starts happening
regularly I'll investigate further.

Cheers,

Will
