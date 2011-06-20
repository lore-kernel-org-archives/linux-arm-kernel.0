From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 15:17:53 +0100
Subject: [PATCH 0/4] Consistently enter the kernel in ARM state
In-Reply-To: <alpine.LFD.2.00.1106200957120.2142@xanadu.home>
References: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1106200957120.2142@xanadu.home>
Message-ID: <20110620141753.GB6310@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 10:01:11AM -0400, Nicolas Pitre wrote:
> On Mon, 20 Jun 2011, Dave Martin wrote:
> 
> > This series rationalises the kernel entry requirements so that
> > Image is entered in ARM state, just like zImage.
> > 
> > This should enable Image to be booted reliably for Thumb-2 kernels,
> > just like zImage.
> > 
> > The Booting documentation is updated to describe the requirement:
> > this resolves the ARM/Thumb ambiguity for Thumb-2 kernels; for ARM
> > kernels there is no implied change.
> > 
> > Dave Martin (4):
> >   ARM: head: Always Enter the kernel in ARM state
> >   ARM: head-nommu: Always enter the kernel in ARM state
> >   ARM: zImage: Jump to the decompressed kernel entry point in ARM state
> 
> I'm afraid the above 3 patches will have to be folded together, 
> otherwise a Thumb2 kernel won't boot if the last patch is not applied, 
> which might cause problems with git bisect.

Hmm, I was wondering about that.

> Otherwise you can add "Acked-by Nicolas Pitre <nicolas.pitre@linaro.org>"
> to all of them.

I'll fold the patches together.  It's a small series, so that shouldn't
cause trouble for people.

Thanks for the feedback.

Cheers
---Dave
