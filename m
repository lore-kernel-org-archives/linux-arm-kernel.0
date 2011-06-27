From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jun 2011 17:29:54 +0200
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <20110627100212.GA16103@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
	<20110623133702.GZ23234@n2100.arm.linux.org.uk>
	<BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
	<BANLkTinK88QT_7Zr2YF1sTAiM778Xp9rFQ@mail.gmail.com>
	<20110627100212.GA16103@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=NTqQ-U8AhL0SUYzBTs1RF==aD5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 12:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The next thing to think about in DMA-land is whether we should total up
> the size of the SG list and choose whether to flush the individual SG
> elements or do a full cache flush. ?There becomes a point where the full
> cache flush becomes cheaper than flushing each SG element individually.

We noticed that even for a single (large) buffer, any cache flush operation
above a certain threshold flushing indiviudal lines become more expensive
than flushing the entire cache.

I requested colleagues to look into implenting this threshold in the
arch/arm/mm/cache-v7.S file. but I think they ran into trouble and
eventually had to give up on it.

Vijay or Srinidhi, can you share your findings?

Thanks,
Linus Walleij
