From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Feb 2011 11:30:20 +0100
Subject: [PATCH] mmci: make sure DMA transfers wait for FIFO drain
In-Reply-To: <20110211101056.GB23404@n2100.arm.linux.org.uk>
References: <1296509980-29987-1-git-send-email-linus.walleij@linaro.org>
	<20110201110348.GB31216@n2100.arm.linux.org.uk>
	<AANLkTi=jP1G=foehWYNai5H=_F372FwpkLEO4wSkmqBc@mail.gmail.com>
	<20110211101056.GB23404@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikOArp9y4bTsvKCxtShoTzzsQeABfPn0z+dGneL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/11 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Maybe a solution to this is to use the DMA callback to signal that the
> data path has completed, but still have the data end interrupt in place
> so that it can trigger the stop command. ?That shouldn't result in
> additional delays or even the requirement for a timeout.

That should be possible, I'll try to fix up a patch like that.

Thanks,
Linus Walleij
