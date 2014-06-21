From: agross@codeaurora.org (Andy Gross)
Date: Sat, 21 Jun 2014 13:56:46 -0500
Subject: [Patch v2 1/3] spi: qup: Remove chip select function
In-Reply-To: <20140621101303.GE5099@sirena.org.uk>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
 <1402601652-24641-2-git-send-email-agross@codeaurora.org>
 <20140621101303.GE5099@sirena.org.uk>
Message-ID: <20140621185646.GA2601@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 11:13:03AM +0100, Mark Brown wrote:
> On Thu, Jun 12, 2014 at 02:34:10PM -0500, Andy Gross wrote:
> > This patch removes the chip select function.  Chip select should instead be
> > supported using GPIOs, defining the DT entry "cs-gpios", and letting the SPI
> > core assert/deassert the chip select as it sees fit.
> 
> Why?

The chip select control inside the controller is buggy.  It is supposed to
automatically assert the chip select based on the activity in the controller,
but it is buggy and doesn't work at all.  So instead we elect to use GPIOs.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
