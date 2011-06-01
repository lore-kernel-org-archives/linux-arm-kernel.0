From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 1 Jun 2011 11:59:25 -0400 (EDT)
Subject: [PATCH v2 0/2] sdio: add quirk for spurious SDIO IRQ
In-Reply-To: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
Message-ID: <alpine.LFD.2.00.1106011157000.30544@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Jun 2011, Per Forlin wrote:

> From: Per Forlin <per.forlin@linaro.org>
> 
> Daniel Drake reported an issue in the libertas sdio client that was
> triggered by the sdio_single_irq functionality. His SDIO device seems to
> raise an interrupt even though there are no bits set in the CCCR_INTx
> register. This behaviour is not supported by the sdio_single_irq feature nor
> the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
> overhead of checking the CCCR_INTx registers, this result in no error
> handling of the case if there is a pending IRQ with none CCCR_INTx bits set.
> 
> This patchset adds a quirk to support this spurious IRQ issue and also report
> a warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.

Given that the issue can be fixed locally to the libertas driver, I'd 
suggest not merging this series until truly unfixable issues come up, as 
Daniel said.


Nicolas
